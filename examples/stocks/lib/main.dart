// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library stocks;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
import 'package:intl/intl.dart';

import 'i18n/stock_messages_all.dart';
import 'stock_data.dart';
import 'stock_home.dart';
import 'stock_settings.dart';
import 'stock_strings.dart';
import 'stock_symbol_viewer.dart';
import 'stock_types.dart';

class StocksApp extends StatefulComponent {
  StocksAppState createState() => new StocksAppState();
}

class StocksAppState extends State<StocksApp> {

  final Map<String, Stock> _stocks = <String, Stock>{};
  final List<String> _symbols = <String>[];

  StockConfiguration _configuration = new StockConfiguration(
    stockMode: StockMode.optimistic,
    backupMode: BackupMode.enabled,
    debugShowGrid: false,
    debugShowSizes: false,
    showPerformanceOverlay: false,
    showSemanticsDebugger: false
  );

  void initState() {
    super.initState();
    new StockDataFetcher((StockData data) {
      setState(() {
        data.appendTo(_stocks, _symbols);
      });
    });
  }

  void configurationUpdater(StockConfiguration value) {
    setState(() {
      _configuration = value;
    });
  }

  ThemeData get theme {
    switch (_configuration.stockMode) {
      case StockMode.optimistic:
        return new ThemeData(
          brightness: ThemeBrightness.light,
          primarySwatch: Colors.purple
        );
      case StockMode.pessimistic:
        return new ThemeData(
          brightness: ThemeBrightness.dark,
          accentColor: Colors.redAccent[200]
        );
    }
  }

  Route _getRoute(RouteSettings settings) {
    List<String> path = settings.name.split('/');
    if (path[0] != '')
      return null;
    if (path[1] == 'stock') {
      if (path.length != 3)
        return null;
      if (_stocks.containsKey(path[2])) {
        return new MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) => new StockSymbolPage(stock: _stocks[path[2]])
        );
      }
    }
    return null;
  }

  Future<LocaleQueryData> _onLocaleChanged(Locale locale) async {
    String localeString = locale.toString();
    await initializeMessages(localeString);
    Intl.defaultLocale = localeString;
    return StockStrings.instance;
  }

  Widget build(BuildContext context) {
    assert(() {
      debugPaintSizeEnabled = _configuration.debugShowSizes;
      return true;
    });
    return new MaterialApp(
      title: 'Stocks',
      theme: theme,
      debugShowMaterialGrid: _configuration.debugShowGrid,
      showPerformanceOverlay: _configuration.showPerformanceOverlay,
      showSemanticsDebugger: _configuration.showSemanticsDebugger,
      routes: <String, RouteBuilder>{
         '/':         (RouteArguments args) => new StockHome(_stocks, _symbols, _configuration, configurationUpdater),
         '/settings': (RouteArguments args) => new StockSettings(_configuration, configurationUpdater)
      },
      onGenerateRoute: _getRoute,
      onLocaleChanged: _onLocaleChanged
    );
  }
}

void main() {
  runApp(new StocksApp());
}

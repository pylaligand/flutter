// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class SliderDemo extends StatefulComponent {
  _SliderDemoState createState() => new _SliderDemoState();
}

class _SliderDemoState extends State<SliderDemo> {
  double _value = 25.0;

  Widget build(BuildContext context) {
    return new Scaffold(
      toolBar: new ToolBar(center: new Text("Sliders")),
      body: new Block(children: <Widget>[
        new Container(
          height: 100.0,
          child: new Center(
            child:  new Row(
              children: <Widget>[
                new Slider(
                  value: _value,
                  min: 0.0,
                  max: 100.0,
                  onChanged: (double value) {
                    setState(() {
                      _value = value;
                    });
                  }
                ),
                new Container(
                  padding: const EdgeDims.symmetric(horizontal: 16.0),
                  child: new Text(_value.round().toString().padLeft(3, '0'))
                ),
              ],
              justifyContent: FlexJustifyContent.collapse
            )
          )
        ),
        new Container(
          height: 100.0,
          child: new Center(
            child:  new Row(
              children: <Widget>[
                // Disabled, but tracking the slider above.
                new Slider(value: _value / 100.0),
                new Container(
                  padding: const EdgeDims.symmetric(horizontal: 16.0),
                  child: new Text((_value / 100.0).toStringAsFixed(2))
                ),
              ],
              justifyContent: FlexJustifyContent.collapse
            )
          )
        )
      ])
    );
  }
}

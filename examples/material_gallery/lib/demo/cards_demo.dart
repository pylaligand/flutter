// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TravelDestination {
  const TravelDestination({ this.assetName, this.title, this.description });

  final String assetName;
  final String title;
  final List<String> description;

  bool get isValid => assetName != null && title != null && description?.length == 3;
}

final List<TravelDestination> destinations = <TravelDestination>[
  const TravelDestination(
    assetName: 'packages/flutter_gallery_assets/top_10_australian_beaches.png',
    title: 'Top 10 Australian beaches',
    description: const <String>[
      'Number 10',
      'Whitehaven Beach',
      'Whitsunday Island, Whitsunday Islands'
    ]
  ),
  const TravelDestination(
    assetName: 'packages/flutter_gallery_assets/kangaroo_valley_safari.png',
    title: 'Kangaroo Valley Safari',
    description: const <String>[
      '2031 Moss Vale Road',
      'Kangaroo Valley 2577',
      'New South Wales'
    ]
  )
];

class TravelDestinationItem extends StatelessComponent {
  TravelDestinationItem({ Key key, this.destination }) : super(key: key) {
    assert(destination != null && destination.isValid);
  }

  final TravelDestination destination;

  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle titleStyle = theme.text.headline.copyWith(color: Colors.white);
    TextStyle descriptionStyle = theme.text.subhead;
    TextStyle buttonStyle = theme.text.button.copyWith(color: theme.primaryColor);

    return new Card(
      child: new SizedBox(
        height: 328.0,
        child: new Column(
          children: <Widget>[
            // photo and title
            new SizedBox(
              height: 184.0,
              child: new Stack(
                children: <Widget>[
                  new Positioned(
                    left: 0.0,
                    top: 0.0,
                    bottom: 0.0,
                    right: 0.0,
                    child: new AssetImage(
                      name: destination.assetName,
                      fit: ImageFit.cover
                    )
                  ),
                  new Positioned(
                    bottom: 16.0,
                    left: 16.0,
                    child: new Text(destination.title, style: titleStyle)
                  )
                ]
              )
            ),
            // description and share/expore buttons
            new Flexible(
              child: new Padding(
                padding: const EdgeDims.all(16.0),
                child: new Column(
                  justifyContent: FlexJustifyContent.start,
                  alignItems: FlexAlignItems.start,
                  children: <Widget>[
                    // three line description
                    new Text(destination.description[0], style: descriptionStyle),
                    new Text(destination.description[1], style: descriptionStyle),
                    new Text(destination.description[2], style: descriptionStyle),
                    // share, explore buttons
                    new Flexible(
                      child: new Row(
                        justifyContent: FlexJustifyContent.start,
                        alignItems: FlexAlignItems.end,
                        children: <Widget>[
                          new Padding(
                            padding: const EdgeDims.only(right: 16.0),
                            child: new Text('SHARE', style: buttonStyle)
                          ),
                          new Text('EXPLORE', style: buttonStyle)
                        ]
                      )
                    )
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }
}

class CardsDemo extends StatelessComponent {
  Widget build(BuildContext context) {
    return new Scaffold(
      toolBar: new ToolBar(
        center: new Text("Travel Stream")
      ),
      body: new Block(
        padding: const EdgeDims.only(top: 8.0, left: 8.0, right: 8.0),
        children: destinations.map((TravelDestination destination) {
          return new Container(
            margin: const EdgeDims.only(bottom: 8.0),
            child: new TravelDestinationItem(destination: destination)
          );
        })
        .toList()
      )
    );
  }
}

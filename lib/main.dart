// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// A simple "rough and ready" example of localizing a Flutter app.
// Spanish and English (locale language codes 'en' and 'es') are
// supported.

// The pubspec.yaml file must include flutter_localizations in its
// dependencies section. For example:
//
// dependencies:
//   flutter:
//   sdk: flutter
//  flutter_localizations:
//    sdk: flutter

// If you run this app with the device's locale set to anything but
// English or Spanish, the app's locale will be English. If you
// set the device's locale to Spanish, the app's locale will be
// Spanish.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/rendering.dart';

import 'package:mapbox_gl/controller.dart';
import 'package:mapbox_gl/flutter_mapbox.dart';
import 'package:mapbox_gl/overlay.dart';
import './person.dart';
import './setting.dart';

import './localization.dart';
import './globalSingle.dart';
import './request.dart';

GlobalVaribles global = new GlobalVaribles();

class ChargeState extends StatefulWidget {
  @override
  ChargeApp createState() => new ChargeApp();
}

class ChargeApp extends State<ChargeState> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  VoidCallback _showBottomSheetCallback;

  @override
  void initState() {
    super.initState();
    _showBottomSheetCallback = _showBottomSheet;
    Map<String, String> parameter = {
      'clientId': '2',
      'password': '123456',
      'name':'18910195484',
    };
    fetchGet('users/login', parameter).then((result){
      if(result['errcode'] == 0){
        global.accessToken = result['data']['access_token'];
      } else{
        print(result['errmsg']);
      }
    });
  }

  void _showBottomSheet() {
    setState(() {
      // disable the button
      _showBottomSheetCallback = null;
    });
    _scaffoldKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
          final ThemeData themeData = Theme.of(context);
          return new Container(
              decoration: new BoxDecoration(
                  border: new Border(
                      top: new BorderSide(color: themeData.disabledColor))),
              child: new Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: new Text(
                      'This is a Material persistent bottom sheet. Drag downwards to dismiss it.',
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          color: themeData.accentColor, fontSize: 24.0))));
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              // re-enable the button
              _showBottomSheetCallback = _showBottomSheet;
            });
          }
        });
  }

  void _showMessage() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          content: const Text('You tapped the floating action button.'),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'))
          ],
        );
      },
    );
  }

  final MapboxOverlayController controller = new MapboxOverlayController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          centerTitle: true,
          title: new Text(
            ChargeLocalizations.of(context).title,
            style: new TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: _showMessage,
          backgroundColor: Colors.redAccent,
          child: const Icon(
            Icons.add,
            semanticLabel: 'Add',
          ),
        ),
        body: new Column(
          children: [
            new Container(
              child: new Row(children: [
                new IconButton(
                    icon: new Icon(Icons.person),
                    color: Colors.grey[500],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingPage()),
                      );
                    }),
                new Expanded(
                  flex: 1,
                  child: new TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: ChargeLocalizations.of(context).hint),
                    autofocus: false,
                    onChanged: (String text) {},
                    onSubmitted: (String text) {},
                  ),
                ),
                new IconButton(
                  icon: new Icon(Icons.list),
                  color: Colors.grey[500],
                  onPressed: _showBottomSheetCallback,
                ),
              ]),
            ),
            new Expanded(
              flex: 1,
              child: new MapboxOverlay(
                controller: controller,
                options: new MapboxMapOptions(
                  style: Style.mapboxStreets,
                  camera: new CameraPosition(
                      target: new LatLng(lat: 39.9, lng: 116.5),
                      zoom: 11.0,
                      bearing: 180.0,
                      tilt: 0.0),
                ),
              ),
            ),
          ],
        ));
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      onGenerateTitle: (BuildContext context) =>
          ChargeLocalizations.of(context).title,
      localizationsDelegates: [
        const ChargeLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('zh', ''),
      ],
      // Watch out: MaterialApp creates a Localizations widget
      // with the specified delegates. DemoLocalizations.of()
      // will only find the app's Localizations widget if its
      // context is a child of the app.
      home: new ChargeState(),
    );
  }
}

void main() {
  // debugPaintSizeEnabled = true;
  runApp(new Home());
}

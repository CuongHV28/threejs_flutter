import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Three.js in Flutter wtf')),
        body: WebViewContainer(),
      ),
    );
  }
}

class WebViewContainer extends StatefulWidget {
  @override
  _WebViewContainerState createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadFlutterAsset('assets/threejs-house/index.html')
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      );
    // _loadHtmlFromAssets();
  }

  void _showHouse() {
    final houseSettings = {
      "firstFloor": {
        "FrontWallSettings": "LargeSideD1W1",
        "LeftWallSettings": "LargeSidePlain",
        "BackWallSettings": "LargeSidePlain",
        "RightWallSettings": "LargeSideW1",
        "StairSettings": "stairSettings"
      },
      "highFloors": [
        {
          "FrontWallSettings": "LargeSideD2B",
          "LeftWallSettings": "LargeSidePlain",
          "BackWallSettings": "LargeSidePlain",
          "RightWallSettings": "LargeSideW1",
          "StairSettings": "stairSettings"
        },
        {
          "FrontWallSettings": "LargeSideD2B",
          "LeftWallSettings": "LargeSidePlain",
          "BackWallSettings": "LargeSidePlain",
          "RightWallSettings": "LargeSideW1",
          "StairSettings": "stairSettings"
        }
      ],
      "roof": "RoofBoxHasRailingsSideExits",
      "wallMaterial": "wallMaterial3",
      "isNhaCap4": false
    };

    final jsonString = jsonEncode(houseSettings);
    _controller.runJavaScript('window.showHouse($jsonString);');
  }

  @override
  Widget build(BuildContext context) {
    // return WebViewWidget(controller: _controller);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Three.js House'),
      ),
      body: WebViewWidget(controller: _controller),
      floatingActionButton: FloatingActionButton(
        onPressed: _showHouse,
        child: const Icon(Icons.house),
      ),
    );
  }
}

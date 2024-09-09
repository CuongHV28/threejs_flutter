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

  String? _retrievedHouseSettings;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..setBackgroundColor(const Color(0x00000000))
      ..loadFlutterAsset('assets/threejs-house/index.html')
      // ..loadRequest(Uri.parse('http://10.0.2.2:3070'))
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

  void _saveHouseSettings() async {
    final result = await _controller
        .runJavaScriptReturningResult('window.getHouseSettings();');
    setState(() {
      _retrievedHouseSettings = result as String;
    });
    print('House settings: $_retrievedHouseSettings');
    // Navigator.of(context).pop(); // Close the WebView
    // try {
    //   final result = await _controller
    //       .runJavaScriptReturningResult('window.getHouseSettings();');
    //   setState(() {
    //     _retrievedHouseSettings = result as String;
    //   });
    //   print('House settings: $_retrievedHouseSettings');
    //   Navigator.of(context).pop(); // Close the WebView
    // } catch (e) {
    //   print('Error retrieving house settings: $e');
    // }
  }

  // @override
  // Widget build(BuildContext context) {
  //   // return WebViewWidget(controller: _controller);
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Three.js House'),
  //     ),
  //     body: WebViewWidget(controller: _controller),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: _showHouse,
  //       child: const Icon(Icons.house),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Three.js House'),
      ),
      body: Column(
        children: [
          Expanded(
            child: WebViewWidget(controller: _controller),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _showHouse,
                child: Text('Show House'),
              ),
              ElevatedButton(
                onPressed: _saveHouseSettings,
                child: Text('Save'),
              ),
            ],
          ),
          if (_retrievedHouseSettings != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('House Settings: $_retrievedHouseSettings'),
            ),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWeb extends StatelessWidget {

  String name;


  MyWeb ({ @required this.name});

  @override
  Widget build(BuildContext context) {
     SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
     backgroundColor: Color.fromARGB(250, 245, 245, 245),
          appBar: new AppBar(
                 title: new Text("Farmácia"),
                 backgroundColor: Colors.blueGrey,),

      body: MyWebSample(name : name),

    );
  }
}

class MyWebSample extends StatefulWidget {
  String name;

  MyWebSample ({@required this.name});
  @override
  State<MyWebSample> createState() => MyWebSampleState(name : name);
}

class MyWebSampleState extends State<MyWebSample> {
  String name;

  MyWebSampleState ({@required this.name});

  

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: WebView(
            initialUrl: 'https://www.google.com/search?q=' + name,
            javascriptMode: JavascriptMode.unrestricted,
          )
      );
  }
}
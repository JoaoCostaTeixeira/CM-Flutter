import 'dart:async';
import 'package:flutter/material.dart';


import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

bool _done = false;
final String result = "";

class QR_Result {
  static String res_name = result;
}

class QRScan extends StatefulWidget {
  @override
  QRScanState createState() {
    return new QRScanState();
  }
}

class QRScanState extends State<QRScan> {
  static String result = "No results yet. Please scan in the button bellow.";

  Future _scanQR() async { // Wait until it's done
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        if(qrResult.startsWith("http"))
        {
          var lista = new List(5);
          lista = qrResult.split('/');
          result = lista[4];
          print(result);
        }
        else {
          result = qrResult;
        }
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied.";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex.";
        });
      }
    } on FormatException {
      setState(() {
        result = "Scanning unsuccessful. Please try again.";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    if(!_done) {
      _scanQR();
      _done = true;
    }
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: wineBar("QR CODE SCANNER"),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Center Button
            mainAxisSize: MainAxisSize.min, // Center Button
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.amber,
                        style: BorderStyle.solid,
                        width: 1.0
                    ),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20.0)
                ),
                child: InkWell(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Center(
                      child:
                      Text(result, textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            //fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'
                        ),
                      ),
                    )
                ),
              ),
              Container(
                height: 40.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  color: new Color(0xffa32942), // Cor do Vinho???
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/connectedDevice');
                    },

                    child: Center(
                      child: Text(
                        'Connect',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ]
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        backgroundColor: Colors.amber,
        label: Text("Scan"),
        onPressed: _scanQR,
      ),



      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );


  }
  static AppBar wineBar(String title) {
    return new AppBar
      (
      centerTitle: true,
      title: Text(title, textAlign: TextAlign.center ,
        style: TextStyle(
            fontSize: 30.0,
            //fontFamily: 'Inconsolata',
            //fontWeight: FontWeight.bold,
            color: Color(0xffa32942)
        ),
      ),
      elevation: 0.5, // 2
      iconTheme: IconThemeData(
        color: Colors.grey, //change your color here
      ),
      //centerTitle: true,
      backgroundColor: Colors.white,
      actions: <Widget>[
        Padding(padding: EdgeInsets.fromLTRB(0.0, 15.0, 10.0, 15.0),
          child: Image.asset('assets/images/winegrid-small-logo.png',color: Colors.black),
        ),
      ],
    );
  }
}
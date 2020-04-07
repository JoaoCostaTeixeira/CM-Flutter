import 'dart:async';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'model/medicationList.dart';
void main() => runApp(QR());

class QR extends StatelessWidget {

 
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
                 title: new Text("Adicionar Medicamento"),
                 backgroundColor: Colors.redAccent,),

      body: QRSample(),
    );
  }
}

class QRSample extends StatefulWidget {
  @override
  State<QRSample> createState() => QRSampleState();
}

class QRSampleState extends State<QRSample> {
 String barcode = "";
  String image = "";
 ListMed m = new ListMed();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: RaisedButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: scan,
                    child: const Text('START CAMERA SCAN')
                ),
              )
              ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(barcode, textAlign: TextAlign.center,  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),),
              ),
              (image!="" ? 
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Image.network(
                             image,
                            width: 210,
                            height: 210,
                        ), )
              :
              new Spacer()
              )
              
              ,
            ],
          ),
        ));
  }

        Future scan() async {
          try {
            String barcode = await BarcodeScanner.scan();
            Medication c = m.getOne(int.parse(barcode));
            setState(() {
               this.barcode = c.name + " -" + c.size.toString() + " Comprimidos";
               this.image = c.image;
            });
          } on PlatformException catch (e) {
            if (e.code == BarcodeScanner.CameraAccessDenied) {
              setState(() {
                this.barcode = 'The user did not grant the camera permission!';
              });
            } else {
              setState(() => this.barcode = 'Unknown error: $e');
            }
          } on FormatException{
            setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
          } catch (e) {
            setState(() => this.barcode = 'Unknown error: $e');
          }
        }
      }
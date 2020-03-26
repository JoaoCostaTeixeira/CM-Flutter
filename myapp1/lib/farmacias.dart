import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';


void main() => runApp(Farmacias());




class Farmacias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(250, 245, 245, 245),
          appBar: new AppBar(
                 title: new Text("Farmácias"),
                 backgroundColor: Colors.orangeAccent,),

      body: FarmaciasSample(),
    );
  }
}
 bool isSwitched = true;

class FarmaciasSample extends StatefulWidget {
  @override
  State<FarmaciasSample> createState() => FarmaciasSampleState();
}





/*
Future<LocationData> 
}*/

class FarmaciasSampleState extends State<FarmaciasSample> {
  
  bool serviceStatus = false;
  bool loading = true;
  bool permission = false;
  Location location = new Location();
  LocationData locationData;
// verifica se o serviço esta on
  _getServiceStatus() async {
      bool _serviceEnabled;
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          setState(() {
            loading = false;
          });
        }else{
            setState(() {
            serviceStatus = true;
          });
        }
      }else{
        setState(() {
            serviceStatus = true;
          });
      }
    }
  _getPermission() async {

    PermissionStatus _permissionGranted;
    _permissionGranted = await location.hasPermission();
     print('oioi1');
        if (_permissionGranted == PermissionStatus.DENIED) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted != PermissionStatus.GRANTED) {
              setState(() {
              permission = true;
            });
          }else{
             setState(() {
            loading = false;
            permission = false;
          });
          }
        }else{
          setState(() {
            permission = true;
          });
        }             
    }

    _getLocation() async {
          await location.getLocation().then((local){
                   setState(() {
                      loading = false;
                      locationData=local ;
                    });

          });
         }  


    @override
    void initState() {
          _getServiceStatus().then( 
            (Null) {
              _getPermission().then(
                (Null) {
                   _getLocation() ;
                }
              );
            });
    }

  @override
  Widget build(BuildContext context) {
    if(loading){
      return Scaffold(
                  body: Center(
                    child: Text( 
                    'Loading.....',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black)),
                ),
                    );
    }else{
        if(!serviceStatus){
           return Scaffold(
                  body: Text( 'ligar GPS'),
                );
        }else{
          if(permission){
           return Scaffold(
                  body: Center(
                    child: Text( 
                    locationData.latitude.toString() + "\n" + locationData.longitude.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black)),
                ),
                    );
          }else{
            return Scaffold(
                  body: Text( 'sem Permissao'),
                );
          }
          
        }
    }
    
  }
}
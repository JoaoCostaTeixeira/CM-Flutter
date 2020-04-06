import 'dart:async';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'model/house.dart';

void main() => runApp(Houses());




class Houses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(250, 245, 245, 245),
          appBar: new AppBar(
                 title: new Text("Farmácias"),
                 backgroundColor: Colors.blueGrey,),

      body: HousesSample(),
    );
  }
}
 bool isSwitched = true;

class HousesSample extends StatefulWidget {
  @override
  State<HousesSample> createState() => HousesSampleState();
}

class HousesSampleState extends State<HousesSample> {
  
  bool serviceStatus = false;
  bool loading = true;
  bool permission = false;
  Location location = new Location();
  LocationData locationData;
  List<House> listh;


_getHouses() async {
    houses().then(
        (houseList) {
            if(houseList.length==0){
              print("fds");
            }else{
              print("crl");
            }
        }

    );
}

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
        if (_permissionGranted != PermissionStatus.GRANTED) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted == PermissionStatus.GRANTED) {
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
                      locationData=local ;
                    });

          });
         }  


    @override
    void initState() {
      loading = true;
          _getServiceStatus().then( 
            (Null) {
              if(loading){
                  _getPermission().then(
                      (Null) {
                          if(loading){  
                            _getLocation().then(

                            );   
                          }
                   });
                }
            }
          );
      }

  @override
  Widget build(BuildContext context) {
    if(loading){
      return Scaffold(
                  backgroundColor: Color.fromRGBO(229,239,241, 100),
                  body: Center(
                    child: Image.asset(
                    'assets/images/loading.gif',
                    height: 205.0,
                    width: 205.0,
                  ),
                ),
                    );
    }else{
        if(!serviceStatus){
           return Scaffold(
                  backgroundColor: Color.fromRGBO(224,255,255, 1.0),
                  body: Center(
                        child:
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(15),
                                child:
                                    Image.asset(
                                      'assets/images/localicon.jpg',
                                      height: 205.0,
                                      width: 205.0,
                                    ),
                              ),
                               Padding(
                                padding: EdgeInsets.all(15),
                                  child:
                                    Text(
                                        'Esta funcionalidade necessita que tenha o GPS ligado',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                                          textAlign: TextAlign.center
                                    ),
                              ),
                               Padding(
                                padding: EdgeInsets.only(top: 15, left: 60, right: 60),
                                  child:
                                     RaisedButton(
                                        elevation:5.0,
                                        color : Colors.blueGrey,
                                        onPressed: () {
                                            setState(() {
                                              loading = true ;
                                            });
                                            initState();
                                        },
                                        child: new Center(
                                              child:Text(
                                                    'Ligar GPS',
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                                 
                                               ),
                                              ),
                                      ),
                              ),
                          ],
                        ),
                    ),
                );
        }else{
          if(permission){
                return Scaffold(
                  backgroundColor: Color.fromRGBO(224,255,255, 1.0),
                  body: Center(
                        child:
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(15),
                                child:
                                    Image.asset(
                                      'assets/images/localicon.jpg',
                                      height: 205.0,
                                      width: 205.0,
                                    ),
                              ),
                               Padding(
                                padding: EdgeInsets.all(15),
                                  child:
                                    Text(
                                        'Esta funcionalidade percisa da sua premissão para aceder ao GPS',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                                          textAlign: TextAlign.center
                                    ),
                              ),
                               Padding(
                                padding: EdgeInsets.only(top: 15, left: 60, right: 60),
                                  child:
                                     RaisedButton(
                                        elevation:5.0,
                                        color : Colors.blueGrey,
                                        onPressed: () {
                                           setState(() {
                                              loading = true ;
                                            });
                                            initState();
                                        },
                                        child: new Center(
                                              child:Text(
                                                    'Dar Permissão',
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                                 
                                               ),
                                              ),
                                      ),
                              ),
                          ],
                        ),
                    ),
                );
       
          }else{
            return Scaffold(
                  backgroundColor: Color.fromRGBO(224,255,255, 1.0),
                  body: Center(
                        child:
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(15),
                                child:
                                    Image.asset(
                                      'assets/images/localicon.jpg',
                                      height: 205.0,
                                      width: 205.0,
                                    ),
                              ),
                               Padding(
                                padding: EdgeInsets.all(15),
                                  child:
                                    Text(
                                        'Esta funcionalidade percisa da sua premissão para aceder ao GPS',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                                          textAlign: TextAlign.center
                                    ),
                              ),
                               Padding(
                                padding: EdgeInsets.only(top: 15, left: 60, right: 60),
                                  child:
                                     RaisedButton(
                                        elevation:5.0,
                                        color : Colors.blueGrey,
                                        onPressed: () {
                                           setState(() {
                                              loading = true ;
                                            });
                                            initState();
                                        },
                                        child: new Center(
                                              child:Text(
                                                    'Dar Permissão',
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                                 
                                               ),
                                              ),
                                      ),
                              ),
                          ],
                        ),
                    ),
                );
          }
          
        }
    }
    
  }
}



class FarmaciasList {
  final List<FarmciaList> results;

  FarmaciasList({this.results});

  factory FarmaciasList.fromJson(Map<String, dynamic> json) {
      var list = json['results'] as List;
      print(list.runtimeType); //returns List<dynamic>
      List<FarmciaList> imagesList = list.map((i) => FarmciaList.fromJson(i)).toList();

    return FarmaciasList(
      results: imagesList,
    );
  }
}

class FarmciaList {

  final String name;

  FarmciaList({this.name});

  factory FarmciaList.fromJson(Map<String, dynamic> json) {
    return FarmciaList(
      name: json['name'],
    );
  }
}
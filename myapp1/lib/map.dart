import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'model/house.dart';


class MyMap extends StatelessWidget {
  String lng;
  MyMap ({this.lng});
 
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
                 title: new Text((lng == "pt" ? "Mapa" : "Maps")),
                 backgroundColor: Colors.green,),

      body: MapSample(lng : lng),
    );
  }
}

class MapSample extends StatefulWidget {
  String lng;
  MapSample ({this.lng});

  @override
  State<MapSample> createState() => MapSampleState(lng :lng);
}

class MapSampleState extends State<MapSample> {

  String lng;
  MapSampleState ({this.lng});

  GoogleMapController _controller;

 CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(40.638272, -8.654327),
    zoom: 0,
  );


  bool serviceStatus = false;
  bool loading = true;
  bool permission = false;
  bool marker = false;
  Location location = new Location();
  LocationData locationData;
  final Set<Marker> _markers= {};
  final dbHelper = DatabaseHelper2.instance;
 Set<Circle> _circles = {}; 
  String nome = "";
  double _value=9.0;
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
    void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text((lng == "pt" ? "Tem a certeza que pertende adicionar esta localização?" :"Are you sure you want to add this location?")),
          actions: <Widget>[
            new FlatButton(
              child: new Text((lng == "pt" ? "Não" : "No")),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text((lng == "pt" ? "Sim" : "Yes")),
              onPressed: () {
                 _addCasa();
                 Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

    _addCasa() async{
        if(nome != " "){
          LatLng center = _circles.first.center;
          Map<String, dynamic> row = {
                  DatabaseHelper2.columnName : nome,
                  DatabaseHelper2.columnLat  : center.latitude,
                  DatabaseHelper2.columnLong : center.longitude,
                  DatabaseHelper2.columnActive : 1,
                  DatabaseHelper2.columnRaio : _value,
                };

            final id = await dbHelper.insert(row);
            print('inserted row id: $id');
            Navigator.pop(context);
        }else{
             showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text((lng == "pt" ? "Por favor adicione um nome à Localização" : "Please add a name to the Location")),
                    actions: <Widget>[
                      new FlatButton(
                        child: new Text("ok"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                },
              );
        }
    }

    _getLocation() async {
          await location.getLocation().then((local){

                   setState(() {
                     _kGooglePlex = CameraPosition (target: LatLng(local.latitude, local.longitude), zoom: 17 );
                      locationData=local ;
                      loading = false;



                    });



          });
         }     
    @override
    void initState() {
          if(marker){
            print("asd");
             LatLng s;
            _markers.map((f){ 
              s =f.position;
              });
            setState(() {
               _kGooglePlex = CameraPosition (target: s, zoom: 17 );
                    
            });
          }else{
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
           return new SingleChildScrollView(
              child:Column(   
                children: <Widget>[
                   Container(
                      height:(marker ? 150 : 0 ),
                      child: 
                      Column(children: <Widget>[
                          Row(
                          children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 4, top: 15),
                              child:
                                 Slider(
                                        
                                        min: 0,
                                        max: 100,
                                        value: _value,
                                        
                                        onChanged: (value) {
                                          Circle s = _circles.first;
                                             _circles.clear();
                                          setState(() {
                                            _value = value;
                                                   _circles.add(Circle(
                                                      circleId: CircleId("1"),
                                                      center: s.center,
                                                      radius: value/2,
                                                      fillColor: Colors.red,
                                                      strokeWidth: 0,
                                                  ));
                                                }
                                            );
                                        },
                                      ),
                                      
                          ),
                          Padding(
                             padding: EdgeInsets.only(left: 4, top: 10, right: 4),
                             child: 
                             ButtonTheme(
                                  minWidth: 50.0,
                                  height: 50.0,
                                  child:  RaisedButton(
                                    elevation: 5.0,
                                    color : Colors.greenAccent,
                                    onPressed: (){
                                      _showDialog();
                                    },
                                    child:  Padding(
                                                padding: const EdgeInsets.only(top:5, left: 5, right: 5, bottom: 5),
                                                child: new Icon(
                                                          Icons.check,
                                                          color: Colors.white,
                                                          size: 30.0,
                                                        ),
                                              ),
                                ),
                                )
                            
                          ),
                          Padding(
                             padding: EdgeInsets.only(left: 4, top: 10, right: 4),
                             child: 
                             ButtonTheme(
                                  minWidth: 50.0,
                                  height: 50.0,
                                  child:  RaisedButton(
                                    elevation: 5.0,
                                    color : Colors.redAccent,
                                    onPressed: (){
                                      setState(() {
                                        _markers.clear();
                                        marker=false;
                                        _circles.clear();
                                        _value = 9.0;
                                      });
                                    },
                                    child:  Padding(
                                                padding: const EdgeInsets.only(top:5, left: 5, right: 5, bottom: 5),
                                                child: new Icon(
                                                          Icons.close,
                                                          color: Colors.white,
                                                          size: 30.0,
                                                        ),
                                              ),
                                ),
                                )
                            
                          ),
                        ]), 
                        Padding(
                          padding: const EdgeInsets.only(top:5, left: 10, right: 10, bottom: 5),
                          child:TextField(
                          decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: (lng == "pt" ? "Nome" : "Name"),
                              ),
                              onChanged:  (text){
                            print(text);
                            setState(() {
                              nome = text;
                            });
                          },
                         ),
                        ),
                      ],),
                      ),
                  Container(
                    height: (marker ? 500 : 640 ),
                    child: GoogleMap(
                      mapType: MapType.hybrid,
                      markers: _markers,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                      },
                      circles: _circles,
                      onTap: (point){
                        if(!marker){  
                          setState(() {
                            _markers.add(
                                Marker(
                                  markerId: MarkerId("1"),
                                  position:point,
                                   icon: BitmapDescriptor.defaultMarker,
                                )
                            );
                             _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition (target: point, zoom: 19)));
                            _circles.add(Circle(
                                  circleId: CircleId("1"),
                                  center: point,
                                  radius: _value/2,
                                  fillColor: Colors.red,
                                  strokeWidth: 0,
                              ));
                            marker=true;

                          });
                        }
                      },
                    ) ,
                  ),
                ],)
              
            );
    }
  }
}
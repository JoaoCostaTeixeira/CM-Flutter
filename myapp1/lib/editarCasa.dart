import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'model/house.dart';

class MyMapEdit extends StatelessWidget {

  String name;
  double raio;
  LatLng center;
  int id;

  MyMapEdit ({ @required this.name, @required this.raio, @required this.center, @required this.id});

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
                 title: new Text("Editar"),
                 backgroundColor: Colors.green,),

      body: MapEditSample(name : name, raio: raio, center: center,id:id),
    );
  }
}

class MapEditSample extends StatefulWidget {
  String name;
  double raio;
  LatLng center;
  int id;

  MapEditSample ({@required this.name, @required this.raio, @required this.center, @required this.id});
  @override
  State<MapEditSample> createState() => MapEditSampleState(name : name, raio: raio, center: center, id: id);
}

class MapEditSampleState extends State<MapEditSample> {
  String name;
  double raio;
  LatLng center;
  int id;

  MapEditSampleState ({@required this.name, @required this.raio, @required this.center,  @required this.id});

  GoogleMapController _controller;

 CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng( 40,8),
    zoom: 0,
  );





  bool loading = true;
  final Set<Marker> _markers= {};
  final dbHelper = DatabaseHelper2.instance;
  Set<Circle> _circles = {}; 
  String nome = "";
  double _value=9.0;
  int ids;



    _update() async{
        if(nome != ""){
          print(ids);
          LatLng center = _circles.first.center;
          Map<String, dynamic> row = {
                  DatabaseHelper2.columnId : ids,
                  DatabaseHelper2.columnName : nome,
                  DatabaseHelper2.columnLat  : center.latitude,
                  DatabaseHelper2.columnLong : center.longitude,
                  DatabaseHelper2.columnActive : 1,
                  DatabaseHelper2.columnRaio : _value,
                };

            final ida = await dbHelper.update(row);
            print('inserted row id: $ida');
            Navigator.pop(context);
        }else{
             showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text("Por favor adicione um nome à Localização"),
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

    void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Tem a certeza que pertende adicionar esta localização?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Não"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Sim"),
              onPressed: () {
                _update();
                 Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
    @override
    void initState() {
            setState(() {
                _value = raio;
                nome = name;
                _circles.add(Circle(
                        circleId: CircleId("1"),
                        center: center,
                        radius: raio/2,
                        fillColor: Colors.red,
                        strokeWidth: 0,
                    ));
                _markers.add(
                      Marker(
                        markerId: MarkerId("1"),
                        position:center,
                          icon: BitmapDescriptor.defaultMarker,
                      )
                  );
                  ids = id;
                  _kGooglePlex = CameraPosition(
                            target: center,
                            zoom: 19,
                          );

                          loading = false;

                            
            });
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
                      height: 150,
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
                                      Navigator.pop(context);
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
                          child:TextFormField(
                          initialValue: name,
                          decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Nome',

                              ),
                              onChanged:  (text){
                            setState(() {
                              nome = text;
                            });
                          },
                         ),
                        ),
                      ],),
                      ),
                  Container(
                    height: 500,
                    child: GoogleMap(
                      mapType: MapType.hybrid,
                      markers: _markers,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                      },
                      circles: _circles,
                      onTap: (point){
                      },
                    ) ,
                  ),
                ],)
              
            );
    }
  }
}
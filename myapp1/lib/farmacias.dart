import 'dart:async';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

void main() => runApp(Farmacias());




class Farmacias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(250, 245, 245, 245),
          appBar: new AppBar(
                 title: new Text("Farmácias"),
                 backgroundColor: Colors.blueGrey,),

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
  List <Padding> farmaciaList = new List();


  
Future<FarmaciasList> fetchFarmacia() async {
  final response =
      await http.get('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location='+locationData.latitude.toString() + ','+locationData.longitude.toString()+'&rankby=distance&language=pt-PT&types=pharmacy&key=AIzaSyAJWnpsN6ex46vpLXYE_A8qeuo776cgHsA');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return FarmaciasList.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
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
        List <Padding> farmaciasss = new List();
          _getServiceStatus().then( 
            (Null) {
              if(loading){
                  _getPermission().then(
                      (Null) {
                          if(loading){                      
                            _getLocation().then(
                              (Null) {
                                   fetchFarmacia().then(
                                     (farmac) {
                                       print(farmac.results.length);
                                         farmac.results.forEach( (f) => print(f.name + " " + f.vicinity + " " + f.geo.local.lat.toString() + " " + f.geo.local.long.toString()));
                                       farmac.results.forEach( (f) =>
                                        
                                            farmaciasss.add( Padding(
                                                                  padding: const EdgeInsets.only(top:10, bottom: 10),
                                                                  child: Container(
                                                                      padding: const EdgeInsets.all(15),
                                                                      height: 200,
                                                                      width:10,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(5.0),
                                                                          color: Colors.white,
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              color: Colors.grey,
                                                                              offset: Offset(1.0, 2.0), //(x,y)
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      child: Text(
                                                                              f.name,
                                                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black54),
                                                                              textAlign: TextAlign.left,
                                                                           ) ,
                                                                      ),
                                                        ),
                                              )
                                       );
                                        setState(() {
                                          farmaciaList = farmaciasss;
                                          loading = false;
                                      });
                                     }
                                   );
                                  
                              }
                            ) ;
                          }
                      }
                );
              }
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
            if(farmaciaList.length == 0){
                 return Scaffold(
                  backgroundColor: Color.fromRGBO(224,255,255, 1.0),
                  body: Center(
                        child: Text(
                            'Não tem farmacias nas proximidades',
                             textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black54),
                                                  
                        ),
                    ),
                );
            }else{
                return Scaffold(
                          backgroundColor: Color.fromRGBO(239,240,241, 1.0),
                          body: new ListView(
                          padding: const EdgeInsets.all(10),
                          children:farmaciaList
                        ),
                    );
            }
       
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
  final String vicinity;
  final GeometryFarm geo;
  FarmciaList({this.name, this.vicinity, this.geo});

  factory FarmciaList.fromJson(Map<String, dynamic> json) {
      var list = json['geometry'] as GeometryFarm;

    return FarmciaList(
      name: json['name'],
      vicinity: json['vicinity'],
      geo : list,
    );
  }
}
class GeometryFarm {
    final LocationFarm local;
    GeometryFarm ({this.local});
    
 factory GeometryFarm.fromJson(Map<String, dynamic> json) {
      var list = json['location'] as LocationFarm;

    return GeometryFarm(
      local: list,
    );
  }
}
class LocationFarm {
  final double lat;
  final double long;

  LocationFarm ({this.lat, this.long});
    factory LocationFarm.fromJson(Map<String, dynamic> json) {
    return LocationFarm(
      lat: json['lat'],
      long: json['lng']
    );
  }
}
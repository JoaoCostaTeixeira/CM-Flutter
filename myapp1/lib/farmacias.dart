import 'dart:async';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'model/farmacias.dart';
import 'webviwer.dart';

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
  List<Farm> farm = new List();
  final dbHelper = DatabaseHelperFarm.instance;
  
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
  //retorna todas as casas
   _query() async {
     farm.clear();
     print('query all rows:');
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) {
      setState(() {                                        
          farmaciaList.add( Padding(
                        padding: const EdgeInsets.only(top:10, bottom: 10),
                        child: Container(
                            padding: const EdgeInsets.only(top:15, left: 15, right: 15),
                            height: 230,
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
                            child:Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top:15, bottom: 5, left: 3, right: 3),
                                  child: Text(
                                    row['nome'],
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black54),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                  
                                  Padding(
                                  padding: const EdgeInsets.only(top:5, left: 3, right: 3),
                                  child: Text(
                                    "Morada: " + row['morada'],
                                    style: TextStyle(fontSize: 15, color: Colors.black54),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                new Spacer(),
                                 Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 140, 
                                    height: 49,
                                    child: FlatButton (
                                      shape:RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(10.0),
                                          side: BorderSide(color: Colors.black38)
                                        ),
                                      onPressed: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => MyWeb(name: row['nome'] + ", " + row['morada'],)),
                                          );
                                      },
                                      color: Colors.blueGrey,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                              'Mais informações',
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white),
                                              textAlign: TextAlign.center,
                                            )
                                        ],
                                      ), 
                                  ),
                                  ), 
                                  new Spacer(),
                                  SizedBox(
                                    width: 90, 
                                    height: 90,
                                    child: FlatButton (
                                      onPressed: (){
                                        
                                      },
                                      color: Colors.transparent,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(right: 14, bottom: 5) ,
                                          child: Icon(Icons.star_border, color: Colors.black,size: 35.0,),
                                          )
                                        ],
                                      ), 
                                  ),
                                  ), 
                                ],
                              ),
                              ],
                            ), 
                            ),
              ),
            );
                                       
      });
      
    });
  }

  _addFar( String n, String v) async{

           Map<String, dynamic> row = {
              DatabaseHelperFarm.columnNome : n,
              DatabaseHelperFarm.columnMorada  : v,
            };
            await dbHelper.insert(row).then((Null){
              print("added");
            });
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
                                       print(farmac.results.toString());
                                       if(0 == 0){
                                             _query().then((Null){
                                                setState(() {
                                                    loading = false;
                                                });
                                             });
                                        
                                       }else{
                                         dbHelper.deleteAll().then((Null){
                                             farmac.results.forEach( (f) => (_addFar(f.name, f.vicinity)));
                                             _query().then((Null){
                                                setState(() {
                                                    loading = false;
                                                });
                                             });
                                         });
                                       }
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
  FarmciaList({this.name, this.vicinity});

  factory FarmciaList.fromJson(Map<String, dynamic> json) {
    return FarmciaList(
      name: json['name'],
      vicinity: json['vicinity'],
    );
  }
}


class Farm {
  
  final int id;
  final String name;
  final String vicinity;
  Farm({this.id,this.name, this.vicinity});
}

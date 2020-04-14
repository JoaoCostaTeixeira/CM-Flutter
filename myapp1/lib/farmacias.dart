import 'dart:async';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import 'model/farmacias.dart';
import 'model/farmaciaFav.dart';

import 'webviwer.dart';

class Farmacias extends StatelessWidget {
  String lng;
  Farmacias ({ @required this.lng}); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(250, 245, 245, 245),
          appBar: new AppBar(
                 title: new Text((lng == 'pt'? "Farmácias" :"Pharmacies" )),
                 backgroundColor: Colors.blueGrey,),

      body: FarmaciasSample(lng : lng),
    );
  }
}

class FarmaciasSample extends StatefulWidget {
  String lng;
  FarmaciasSample ({ @required this.lng}); 
  @override
  State<FarmaciasSample> createState() => FarmaciasSampleState(lng : lng);
}



class FarmaciasSampleState extends State<FarmaciasSample> {
  
  String lng;
  FarmaciasSampleState ({ @required this.lng}); 

  bool serviceStatus = false;
  bool loading = true;
  bool permission = false;

  Location location = new Location();
  LocationData locationData;

  List <Padding> farmaciaList = new List();

  List <Padding> farmaciaListFav = new List();
  List <Farm> farmFav = new List();
  bool fav = false;

  final dbHelper = DatabaseHelperFarm.instance;
  final dbHelper2 = DatabaseHelperFarmFav.instance;
  


// Fetch farmacias proximas
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

  //adiciona todas as Farmacias persentes na cache
  _query() async {
      farmaciaList.clear();
    print('query all rows:');
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) {
      
      setState(() {   
        int x =  verifyFav(row['nome'], row['morada']);                                     
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
                                    (lng == 'pt'?  "Morada: "  :"Address: " ) + row['morada'],
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
                                              (lng == 'pt'? 'Mais informações'  : 'More information' ),
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
                                    child:
                                    ( x!=-1?
                                          FlatButton (
                                              onPressed: (){
                                                _removeFarFav(x);
                                              },
                                              color: Colors.transparent,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 14, bottom: 5) ,
                                                  child: Icon(Icons.star, color: Colors.black,size: 35.0,),
                                                  )
                                                ],
                                              ), 
                                          )
                                      :

                                      FlatButton (
                                            onPressed: (){
                                               _addFarFav(row['nome'], row['morada']);

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
                                        )
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
    setState(() {
      farmaciaList.add(Padding(
                        padding: const EdgeInsets.only(top:10, bottom: 50),
                        child: Container(
                          height: 50,
                          child:Text(''),
                        )));
    });
  }

  //adiciona todas as Farmacias persentes nos favoritos
  _queryFav() async {
    farmFav.clear();
    farmaciaListFav.clear();
    print('query all rows:');
    final allRows = await dbHelper2.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) {
      print('ROW' + row['_id'].toString());
      setState(() {         
          farmFav.add(Farm(id: row['_id'], vicinity: row['morada'], name: row['nome']));                               
          farmaciaListFav.add( Padding(
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
                                   (lng == 'pt'? 'Morada: '  : 'Adress: ' )+ row['morada'],
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
                                              (lng == 'pt'? 'Mais informações'  : 'More information' ),
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
                                    child:
                                          FlatButton (
                                              onPressed: (){
                                                _removeFarFav(row['_id']);
                                              },
                                              color: Colors.transparent,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 14, bottom: 5) ,
                                                  child: Icon(Icons.star, color: Colors.black,size: 35.0,),
                                                  )
                                                ],
                                              ), 
                                          )
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

      setState(() {
      farmaciaList.add(Padding(
                        padding: const EdgeInsets.only(top:10, bottom: 50),
                        child: Container(
                          height: 50,
                          child:Text(''),
                        )));
    });
  }

  // Adiciona Farmacias à cache
  _addFar( String n, String v) async{

           Map<String, dynamic> row = {
              DatabaseHelperFarm.columnNome : n,
              DatabaseHelperFarm.columnMorada  : v,
            };
            await dbHelper.insert(row).then((Null){
              print("added");
            });
  }

    // Adiciona Farmacias aos favoritos
  _addFarFav( String n, String v) async{
          setState(() {
            loading=true;
          });
           Map<String, dynamic> row = {
              DatabaseHelperFarmFav.columnNome : n,
              DatabaseHelperFarmFav.columnMorada  : v,
            };
            await dbHelper2.insert(row).then((Null){
                _queryFav().then((Null){
                    _query().then((Null){
                       setState(() {
                          loading=false;
                        });
                    });
                });
            });
  }

    // Adiciona Farmacias à cache
  _removeFarFav(int id) async{
         setState(() {
            loading=true;
          });
            await dbHelper2.delete(id).then((Null){
                _queryFav().then((Null){
                    _query().then((Null){
                       setState(() {
                          loading=false;
                        });
                    });
              });
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

  //Verifica se tem permissões
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

    // localização do utilizador
    _getLocation() async {
          await location.getLocation().then((local){

                   setState(() {
                      locationData=local ;
                    });

          });
         }  
    
    int verifyFav (String name1, String morada1){
      int ff = -1;
      farmFav.forEach((f){
           if(f.name == name1 && f.vicinity == morada1){
              ff= f.id;
        }
      });
      return ff;
    }

    @override
    void initState() {
      loading = true;
        List <Padding> farmaciasss = new List();
        _queryFav().then(
          (Null){
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
                                
                                       if(farmac.results.length == 0){

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
      if(fav){
        if(farmaciaListFav.length==0){
                return Scaffold(
                  floatingActionButton: RaisedButton (
                                        elevation:5.0,
                                        color : Colors.blueGrey,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(18.0),
                                            side: BorderSide(color: Colors.blueGrey)
                                          ),
                                        onPressed: () {
                                            setState(() {
                                              fav = false;
                                            });
                                          },
                                          child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                      child: new Icon(
                                                                Icons.arrow_back,
                                                              color: Colors.white,
                                                                size: 45.0,
                                                          ),
                                            ),
                                      ),
                  backgroundColor: Color.fromRGBO(224,255,255, 1.0),
                  body: Center(
                        child: Text(
                            (lng == 'pt'? 'Não tem Farmácias Favoritas' : 'There are no Favorite Pharmacies' ),
                             textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black54),
                                                  
                        ),
                    ),
                );

        }else{
                return Scaffold(
                  floatingActionButton: RaisedButton (
                                        elevation:5.0,
                                        color : Colors.blueGrey,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(18.0),
                                            side: BorderSide(color: Colors.blueGrey)
                                          ),
                                        onPressed: () {
                                            setState(() {
                                              fav = false;
                                            });
                                          },
                                          child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                      child: new Icon(
                                                                Icons.arrow_back,
                                                              color: Colors.white,
                                                                size: 45.0,
                                                          ),
                                            ),
                                      ),
                          backgroundColor: Color.fromRGBO(239,240,241, 1.0),
                          body: new ListView(
                          padding: const EdgeInsets.all(10),
                          children:farmaciaListFav
                        ),
                    );
        }
      
      }else{

        if(!serviceStatus){
           return Scaffold(
              floatingActionButton: RaisedButton (
                                        elevation:5.0,
                                        color : Colors.blueGrey,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(18.0),
                                            side: BorderSide(color: Colors.blueGrey)
                                          ),
                                        onPressed: () {
                                            setState(() {
                                              fav = true;
                                            });
                                          },
                                          child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                      child: new Icon(
                                                                Icons.star,
                                                              color: Colors.white,
                                                                size: 45.0,
                                                          ),
                                            ),
                                      ),
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
                                         (lng == 'pt'?  'Esta funcionalidade necessita que tenha o GPS ligado' : 'This feature requires that you have GPS turned on' ),
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
                                                 (lng == 'pt'? 'Ligar GPS' : 'Turn on GPS' ),
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
                    floatingActionButton: RaisedButton (
                                        elevation:5.0,
                                        color : Colors.blueGrey,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(18.0),
                                            side: BorderSide(color: Colors.blueGrey)
                                          ),
                                        onPressed: () {
                                            setState(() {
                                              fav = true;
                                            });
                                          },
                                          child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                      child: new Icon(
                                                                Icons.star,
                                                              color: Colors.white,
                                                                size: 45.0,
                                                          ),
                                            ),
                                      ),
                  backgroundColor: Color.fromRGBO(224,255,255, 1.0),
                  body: Center(
                        child: Text(
                           (lng == 'pt'? 'Não tem farmacias nas proximidades' : 'There are no pharmacies nearby' ),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black54),
                                                  
                        ),
                    ),
                );
            }else{
                return Scaffold(
                  floatingActionButton: RaisedButton (
                                        elevation:5.0,
                                        color : Colors.blueGrey,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(18.0),
                                            side: BorderSide(color: Colors.blueGrey)
                                          ),
                                        onPressed: () {
                                            setState(() {
                                              fav = true;
                                            });
                                          },
                                          child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                      child: new Icon(
                                                                Icons.star,
                                                              color: Colors.white,
                                                                size: 45.0,
                                                          ),
                                            ),
                                      ),
                          backgroundColor: Color.fromRGBO(239,240,241, 1.0),
                          body: new ListView(
                          padding: const EdgeInsets.all(10),
                          children:farmaciaList
                        ),
                    );
            }
       
          }else{
            return Scaffold(
               floatingActionButton: RaisedButton (
                                        elevation:5.0,
                                        color : Colors.blueGrey,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(18.0),
                                            side: BorderSide(color: Colors.blueGrey)
                                          ),
                                        onPressed: () {
                                            setState(() {
                                              fav = true;
                                            });
                                          },
                                          child: Padding(
                                                  padding: const EdgeInsets.all(10),
                                                      child: new Icon(
                                                                Icons.star,
                                                              color: Colors.white,
                                                                size: 45.0,
                                                          ),
                                            ),
                                      ),
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
                                       (lng == 'pt'? 'Esta funcionalidade percisa da sua premissão para aceder ao GPS' : 
                                       'This feature needs your permission to access GPS'),
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
                                                (lng == 'pt'?  'Dar Permissão' : 'Give Permission'),
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

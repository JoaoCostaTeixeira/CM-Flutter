import 'dart:async';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'model/house.dart';
import 'map.dart';
import 'editarCasa.dart';


class Houses extends StatelessWidget {
  String lng;

  Houses ({this.lng});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(250, 245, 245, 245),
          appBar: new AppBar(
                 title: new Text((lng == "pt" ? "Casas" : "Houses")),
                 backgroundColor: Colors.green,),

      body: HousesSample(lng : lng),
    );
  }
}

class HousesSample extends StatefulWidget {
  String lng;

  HousesSample ({this.lng});
  @override
  State<HousesSample> createState() => HousesSampleState(lng : lng);
}

class HousesSampleState extends State<HousesSample> {
  String lng;

  HousesSampleState ({this.lng});
  bool loading = true;
  bool deleating = false;
  final dbHelper = DatabaseHelper2.instance;
  List<House> houseList= [];
  List<Padding> printPad = [];

//Remove uma casa
  _remove(int i) async {
    int s = 0;
    dbHelper.delete(i);
    houseList.forEach(
      (f) {
        if(f.id == i){
          setState(() {
             houseList.removeAt(s);
             printPad.removeAt(s);
          });
        }else{
          s++;
        }
      }
    );
  }

  //retorna todas as casas
   _query() async {
     houseList.clear();
     print('query all rows:');
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) {
      setState(() {
        print(row['_id']);
        houseList.add(
          House(
            id: row['_id'],
            nome: row['name'],
            lat: row ['lat'],
            long: row['long'],
            active: row['active'],
            raio: row['raio'],
          ),
        );
      });
      
    });
  }

// pop up dialog
  void _showDialog(int i, String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text((lng == "pt" ? "Deseja remover $name?" : "Do you want to remove $name?")),
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
                _remove(i);
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
      
    _query().then((Null){
          List<Padding> pad = [];
          int size = houseList.length;
          houseList.forEach((f){
            size --;
            print("id: " + f.id.toString());
             pad.add(
                   Padding(
                             padding: (size == 0 ? const EdgeInsets.only(top:10, bottom: 85) : const EdgeInsets.only(top:10)),
                            child:                         
                              Container(
                                  padding: const EdgeInsets.only(top:10),
                                  height: 135,
                                  width:350,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.black12,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(1.0, 2.0), //(x,y)
                                        ),
                                      ],
                                    ),
                                  child: Column(
                                      children: <Widget>[
                                            Text(
                                             f.nome,
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ) ,
                                            new Spacer(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  
                                                
                                                  
                                                
                                                ],
                                            ),
                                            
                                            Row(children: <Widget>[
                                          Padding(
                                              padding: const EdgeInsets.only(top:10) ,
                                              child:
                                            SizedBox(
                                                  width: 175, 
                                                  height: 60,// specific value

                                                  child:FlatButton (
                                                    shape:RoundedRectangleBorder(
                                                        borderRadius: new BorderRadius.circular(0.0),
                                                        side: BorderSide(color: Colors.black38)
                                                      ),
                                                    onPressed: () {
                                                       Navigator.push(
                                                                context,
                                                                MaterialPageRoute(builder: (context) => MyMapEdit(center : LatLng(f.lat, f.long), raio: f.raio, id : f.id, name : f.nome)),
                                                              ).then( (Null){
                                                              initState();
                                                              });
                                                    },
                                                    color: Colors.transparent,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10) ,
                                                        child: Icon(Icons.settings, color: Colors.white,size: 25.0,),
                                                       ),
                                                      
                                                        Text(
                                                            'Editar',
                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                                                            textAlign: TextAlign.center,
                                                          )
                                                      ],
                                                    ), 
                                                ),
                                                ), 
                                              ),
                                            Padding(
                                              padding: const EdgeInsets.only(top:10) ,
                                              child:
                                            SizedBox(
                                                  width: 175, 
                                                  height: 60,
                                                  child: FlatButton (
                                                    shape:RoundedRectangleBorder(
                                                        borderRadius: new BorderRadius.circular(0.0),
                                                        side: BorderSide(color: Colors.black38)
                                                      ),
                                                    onPressed: (){
                                                     _showDialog(f.id, f.nome);
                                                    },
                                                    color: Colors.transparent,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10) ,
                                                        child: Icon(Icons.close, color: Colors.white,size: 25.0,),
                                                       ),
                                                        Text(
                                                            'Remover',
                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                                                            textAlign: TextAlign.center,
                                                          )
                                                      ],
                                                    ), 
                                                ),
                                                ), 
                                              ),
                                            ],),  
                                      ],
                                    ),
                                  ),
                          ),
              );
          });
            setState(() {
                printPad = pad;
                loading=false;
              });
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
        if(houseList.length==0){
              return Scaffold(
           floatingActionButton: RaisedButton (
              elevation:5.0,
              color : Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.orangeAccent)
                ),
               onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyMap(lng : lng)),
                      ).then( (Null){
                          print("oioioioioiasd");
                          initState();
                        });
                },
                child: Padding(
                         padding: const EdgeInsets.all(10),
                             child: new Icon(
                                      Icons.add,
                                     color: Colors.white,
                                      size: 45.0,
                                ),
                   ),
            ),
                  backgroundColor: Color.fromRGBO(229,239,241, 100),
                  body: Center(
                        child: Text(
                            (lng == "pt" ?  'Não tem Casas Adicionadas': 'No Homes Added'),
                             textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black54),
                                                  
                        ),
                    ),
         );
        }else{
          return Scaffold(
           floatingActionButton: RaisedButton (
              elevation:5.0,
              color : Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.orangeAccent)
                ),
               onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyMap(lng : lng)),
                      ).then( (Null){
                          initState();
                        });
                },
                child: Padding(
                         padding: const EdgeInsets.all(10),
                             child: new Icon(
                                      Icons.add,
                                     color: Colors.white,
                                      size: 45.0,
                                ),
                   ),
            ),
                  backgroundColor: Color.fromRGBO(229,239,241, 100),
                  body: 
                  SingleChildScrollView(
                    child: Center(
                    child: Column (
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:printPad,
                    ),
                  ),
                  ),
                  
         );
        }
         
    }
    
  }
}


class House {
  final int id;
  final String nome;
  final double lat;
  final double long;
  final double raio;
  final int active;

  House({this.id, this.nome, this.lat, this.long, this.raio, this.active});

}





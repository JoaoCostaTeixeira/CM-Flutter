import 'dart:async';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'model/house.dart';
import 'map.dart';

void main() => runApp(Houses());




class Houses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(250, 245, 245, 245),
          appBar: new AppBar(
                 title: new Text("Casas"),
                 backgroundColor: Colors.green,),

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
  
  bool loading = true;
   final dbHelper = DatabaseHelper.instance;
    List<House> houseList= [];
    List<Padding> printPad = [];
   void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : 'Rua José Soares de Almeida',
      DatabaseHelper.columnLat  : 23,
      DatabaseHelper.columnLong  : 23,
      DatabaseHelper.columnActive : 1,
      DatabaseHelper.columnRaio: 10,

    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

   _query() async {
     print('query all rows:');
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) {
      setState(() {
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



    @override
    void initState() {
     // _insert();
    _query().then((Null){
          List<Padding> pad = [];
          houseList.forEach((f){
             pad.add(
                   Padding(
                             padding: const EdgeInsets.only(top:10) ,
                            child:                         
                              Container(
                                  padding: const EdgeInsets.only(top:10),
                                  height: 160,
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
                                                    onPressed: () {},
                                                    color: Colors.transparent,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10) ,
                                                        child: Icon(
                                                                      Icons.settings,
                                                                      color: Colors.white,
                                                                      size: 25.0,
                                                                    ), ),
                                                      
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
                                                  height: 60,// specific value
                                                  
                                                  child: FlatButton (
                                                    shape:RoundedRectangleBorder(
                                                        borderRadius: new BorderRadius.circular(0.0),
                                                        side: BorderSide(color: Colors.black38)
                                                      ),
                                                    onPressed: (){
                                                      
                                                    },
                                                    color: Colors.transparent,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10) ,
                                                        child: Icon(
                                                                      Icons.close,
                                                                      color: Colors.white,
                                                                      size: 25.0,
                                                                    ), ),
                                                      
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
                        MaterialPageRoute(builder: (context) => MyMap()),
                      );
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
                    child: Column (
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:printPad,
                    ),
                  ),
         );
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





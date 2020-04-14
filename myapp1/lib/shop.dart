import 'dart:async';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'model/medicationShop.dart';
import 'map.dart';
import 'addToShop.dart';
import 'model/med.dart';

class Shop extends StatelessWidget {
  String lng;
  Shop({this.lng});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(250, 245, 245, 245),
          appBar: new AppBar(
                 title: new Text((lng == "pt"? "Compras" : "Shop" )),
                 backgroundColor: Colors.lightBlue,),

      body: ShopSample(lng:lng),
    );
  }
}

class ShopSample extends StatefulWidget {
  String lng;
  ShopSample({this.lng});
  @override
  State<ShopSample> createState() => ShopSampleState(lng :lng);
}

class ShopSampleState extends State<ShopSample> {
  String lng;
  ShopSampleState({this.lng});

  bool loading = true;
  bool deleating = false;
  final dbHelper = DatabaseHelper4.instance;
  final dbHelper2 = DatabaseHelper3.instance;
  List<Medicat> houseList= [];
  List<Padding> printPad = [];

//Remove uma casa
  _remove(int i) async {
    dbHelper.delete(i).then((Null){
      initState();
    });
  }

  _query2() async {
     houseList.clear();
     print('query all rows:');
    final allRows = await dbHelper2.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) {
      setState(() {
        print(row['_id']);
        houseList.add(
          Medicat(
            id: row['_id'],
            nome: row['nome'],
            size: row ['size'],
            image: row['image'],
            number : row['number'],
          ),
        );
      });
      
    });
  }



  _addMed( String name1, int size1, String image1, int id1) async{
       bool exist = false;
       int ids = 0;
       int com = 0;

        _query2().then(
            (Null){
                houseList.forEach(
                  (f){
                    if(f.nome == name1){
                      exist = true;
                      ids = f.id;
                      com = f.number;
                    }
                  }
                );
                if(exist){
                    Map<String, dynamic> row = {
                          DatabaseHelper3.columnId : ids,
                          DatabaseHelper3.columnName : name1,
                          DatabaseHelper3.columnImage  : image1,
                          DatabaseHelper3.columnNumber : size1+com,
                          DatabaseHelper3.columnSize : size1,
                        };

                    dbHelper2.update(row).then(
                      (Null){
                        _remove(id1).then((Null){
                            initState();
                        });
                        
                      }
                    );
                }else{
                     Map<String, dynamic> row = {
                          DatabaseHelper3.columnName : name1,
                          DatabaseHelper3.columnImage  : image1,
                          DatabaseHelper3.columnNumber : size1,
                          DatabaseHelper3.columnSize : size1,
                        };
                    dbHelper2.insert(row).then(
                      (Null) {
                         _remove(id1).then((Null){
                            initState();
                        });
                      }
                    );
                    
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
          Medicat(
            id: row['_id'],
            nome: row['nome'],
            size: row ['number'],
            image: row['image'],
            number : row ['number'],
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
          title: new Text("Deseja remover $name?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text((lng == "pt"? "Não" : "No" )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text((lng == "pt"? "Sim" : "Yes" )),
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
      print('Start');
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
                                  padding: const EdgeInsets.only(top:1),
                                  height: 290,
                                  width:350,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.white,
                                      boxShadow: [
                                       BoxShadow(
                                          color: Colors.black45,
                                          offset: Offset(2.0, 3.0), //(x,y)
                                        ),
                                      ],
                                    ),
                                  child:
                                  Column(children: <Widget>[
                                       Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10, right: 10),
                                          child: Container(
                                          width: 110,
                                          height: 110,
                                            child:Image.network(
                                                   f.image,
                                                      width: 110,
                                                      height: 110,
                                                  )
                                          ),),
                                        Column(children: <Widget>[

                                          
                                                Container(
                                                  width: 200,
                                                  height: 80,
                                                  child: Padding( padding: const EdgeInsets.only(top:26,right: 6, left: 2),
                                                  child: Text(
                                                      f.nome,
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black87),
                                                      textAlign: TextAlign.center,
                                                  ),),
                                                ),
                                                 Container(
                                                  width: 200,
                                                  height: 100,
                                                    child:Padding( padding: const EdgeInsets.only(top:14, bottom: 4, right: 5, left: 5),
                                                  child: Text(
                                                      f.size.toString() + (lng=="pt" ? " comprimidos" : " tablets"),
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
                                                      textAlign: TextAlign.center,
                                                  ),),
                                                  ),
                                        ],),
                                      ],
                                  ),
                                  
                                  
                                  
                                  Container(
                                           width: 400,
                                           child: 
                                           Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 10, top: 3, bottom: 3, left: 10) ,
                                                  child: SizedBox(
                                                  width: 80, 
                                                  height: 80,
                                                  child: FlatButton (
                                                    
                                                    shape:RoundedRectangleBorder(
                                                        borderRadius: new BorderRadius.circular(40.0),
                                                        side: BorderSide(color: Colors.black38),
                                                      ),
                                                    onPressed: (){
                                                          _addMed(f.nome, f.number, f.image, f.id);
                                                    },
                                                    color: Colors.green,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 3, top: 3, bottom: 3, left: 3) ,
                                                        child: Icon(Icons.add_shopping_cart, color: Colors.white,size: 40.0,),
                                                       )
                                                      ],
                                                    ), 
                                                ),
                                                ),),
                                                 Padding(
                                                  padding: const EdgeInsets.only(right: 10, top: 3, bottom: 3, left: 10) ,
                                                  child: SizedBox(
                                                  width: 80, 
                                                  height: 80,
                                                  child: FlatButton (
                                                    
                                                    shape:RoundedRectangleBorder(
                                                        borderRadius: new BorderRadius.circular(40.0),
                                                        side: BorderSide(color: Colors.black38),
                                                      ),
                                                    onPressed: (){
                                                        _showDialog(f.id, f.nome);
                                                    },
                                                    color: Colors.red,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 3, top: 3, bottom: 3, left: 3) ,
                                                        child: Icon(Icons.remove_shopping_cart, color: Colors.white,size: 40.0,),
                                                       )
                                                      ],
                                                    ), 
                                                ),
                                                ),),
                                              ],
                                           ),
                                        ),
                                  
                                  
                                  
                                  ],),
                                  
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
                 backgroundColor: Color.fromRGBO(224,255,255, 1.0),
           floatingActionButton: RaisedButton (
              elevation:5.0,
              color : Colors.lightBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.lightBlue)
                ),
               onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QRShop(lng : lng)),
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
                 
                  body: Center(
                        child: Text(
                            (lng=="pt" ? 'Não tem medicamentos na lista de compras' : 'There are no medication on the shopping list'),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black54),
                                                  
                        ),
                    ),
         );
        }else{
          return Scaffold(
             backgroundColor: Color.fromRGBO(224,255,255, 1.0),
           floatingActionButton: RaisedButton (
              elevation:5.0,
              color : Colors.lightBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.lightBlue)
                ),
               onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QRShop(lng : lng)),
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


class Medicat {
  final int id;
  final String nome;
  final int size;
  final String image;
  final int number;

  Medicat({this.id, this.nome, this.size, this.image, this.number});

}





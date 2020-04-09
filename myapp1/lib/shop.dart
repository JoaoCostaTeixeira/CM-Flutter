import 'dart:async';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'model/medicationShop.dart';
import 'map.dart';
import 'addToShop.dart';

void main() => runApp(Shop());

class Shop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(250, 245, 245, 245),
          appBar: new AppBar(
                 title: new Text("Medicamentos"),
                 backgroundColor: Colors.lightBlue,),

      body: ShopSample(),
    );
  }
}

class ShopSample extends StatefulWidget {
  @override
  State<ShopSample> createState() => ShopSampleState();
}

class ShopSampleState extends State<ShopSample> {
  
  bool loading = true;
  bool deleating = false;
  final dbHelper = DatabaseHelper4.instance;
  List<Medicat> houseList= [];
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
          Medicat(
            id: row['_id'],
            nome: row['nome'],
            size: row ['number'],
            image: row['image'],
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
                                  height: 245,
                                  width:350,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.black12,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white12,
                                          offset: Offset(1.0, 2.0), //(x,y)
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
                                                      f.size.toString() + " Comprimidos",
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
                                                    color: Colors.redAccent,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10) ,
                                                        child: Icon(Icons.settings, color: Colors.black87,size: 25.0,),
                                                       ),
                                                        Text(
                                                            'Editar',
                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
                                                            textAlign: TextAlign.center,
                                                          )
                                                      ],
                                                    ), 
                                                ),
                                                ), 
                                                SizedBox(
                                                  width: 175, 
                                                  height: 60,
                                                  child: FlatButton (
                                                    
                                                    shape:RoundedRectangleBorder(
                                                        borderRadius: new BorderRadius.circular(0.0),
                                                        side: BorderSide(color: Colors.black38),
                                                      ),
                                                    onPressed: (){
                                                     _showDialog(f.id, f.nome);
                                                    },
                                                    color: Colors.greenAccent,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10) ,
                                                        child: Icon(Icons.close, color: Colors.black87,size: 25.0,),
                                                       ),
                                                        Text(
                                                            'Tomar 1',
                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
                                                            textAlign: TextAlign.center,
                                                          )
                                                      ],
                                                    ), 
                                                ),
                                                ), 
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
                        MaterialPageRoute(builder: (context) => QRShop()),
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
                    child: Column (
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:[Text("Sem medicamentos na lista de compras")],
                    ),
                  ),
         );
        }else{
          return Scaffold(
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
                        MaterialPageRoute(builder: (context) => QRShop()),
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

  Medicat({this.id, this.nome, this.size, this.image});

}





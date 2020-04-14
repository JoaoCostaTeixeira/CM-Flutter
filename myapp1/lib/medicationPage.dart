import 'dart:async';

import 'dart:convert';
import 'package:flutter/material.dart';

import 'model/med.dart';
import 'model/medicationShop.dart';

import 'map.dart';
import 'add_medication.dart';

import 'editMed.dart';


class Medication extends StatelessWidget {
  String lng;
  Medication({this.lng});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(250, 245, 245, 245),
          appBar: new AppBar(
                 title: new Text((lng == "pt" ? "Medicamentos": "Medicines" )),
                 backgroundColor: Colors.redAccent,),

      body: MedicationSample(lng : lng ),
    );
  }
}

class MedicationSample extends StatefulWidget {
  String lng;
  MedicationSample({this.lng});
  @override
  State<MedicationSample> createState() => MedicationSampleState(lng : lng);
}

class MedicationSampleState extends State<MedicationSample> {
  String lng;
  MedicationSampleState({this.lng});
  bool loading = true;
  bool deleating = false;
  final dbHelper = DatabaseHelper3.instance;
  final dbHelper2 = DatabaseHelper4.instance;


  List<Medicat> houseList= [];
  List<Padding> printPad = [];

  List<Medicat> medShop = [];

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

  //retorna todos os medicamentos
   _query() async {
     medShop.clear();
     print('query all rows:');
    final allRows = await dbHelper2.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) {
      setState(() {
        print(row['_id']);
        medShop.add(
          Medicat(
            id: row['_id'],
            nome: row['nome'],
            size: 0,
            image: row['image'],
            number : row['number'],
          ),
        );
      });
      
    });
  }

  bool _isOnShop(String n1, String i1){
    bool ff=false;
    medShop.forEach((f){
      if(f.image == i1 && f.nome == n1){
        ff = true;
      }
    });
    return ff;
  }


   //retorna todas os medicamentos na shop
   _query2() async {
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
            size: row ['size'],
            image: row['image'],
            number : row['number'],
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
          title: new Text(( lng == "pt" ?  "Deseja remover $name?" : "Do you want to remove $name?" )),
          actions: <Widget>[
            new FlatButton(
              child: new Text((lng == "pt" ?  "Não": "No")),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text((lng == "pt" ?  "Sim": "Yes")),
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
  void _takeOne (int i1, int s1, int n1, String n2, String i2){
    setState(() {
      loading = true;
    });
     Map<String, dynamic> row = {
              DatabaseHelper3.columnId : i1,
              DatabaseHelper3.columnName : n2,
              DatabaseHelper3.columnNumber  : n1-1,
              DatabaseHelper3.columnSize : s1,
              DatabaseHelper3.columnImage : i2,
            };
    dbHelper.update(row).then((Null){
      initState();
    });
  } 


     _addToShop(int n1, String s1, String i1){
           Map<String, dynamic> row = {
              DatabaseHelper4.columnName : s1,
              DatabaseHelper4.columnImage  : i1,
              DatabaseHelper4.columnNumber : n1,
            };
              dbHelper2.insert(row).then((Null){
                initState();
              }
            );
    }



    @override
    void initState() {
      print('Start');
      _query2().then((Null){
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
                                      color: (f.number < 6 ? (_isOnShop(f.nome, f.image) ? Colors.lightBlueAccent  : Color.fromRGBO(255, 179, 179, 0.8))  : Colors.white),
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
                                                  height: 50,
                                                    child:Padding( padding: const EdgeInsets.only(top:14, bottom: 4, right: 5, left: 5),
                                                  child: Text(
                                                      f.number.toString() + (lng=="pt" ? " comprimidos" : " tablets"),
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
                                                      textAlign: TextAlign.center,
                                                  ),),
                                                  ),

                                                  Container(
                                                  width: 200,
                                                  height: 60,
                                                    child:Padding( padding: const EdgeInsets.only(top:1, bottom: 4, right: 5, left: 5),
                                                  child: Text(
                                                      f.size.toString() + (lng=="pt" ?  ' Número de Comprimidos por Caixa' : " Number of Tablets per Box"),
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

                                                (f.number < 6 &&  !_isOnShop(f.nome, f.image)?
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
                                                      _addToShop(f.size, f.nome, f.image);
                                                    },
                                                    color: Colors.blue,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 3, top: 3, bottom: 3, left: 3) ,
                                                        child: Icon(Icons.shopping_cart, color: Colors.white,size: 40.0,),
                                                       )
                                                      ],
                                                    ), 
                                                ),
                                                ),) : Text('')),
                                                 
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 10, top: 3, bottom: 3, left: 10) ,
                                                  child: SizedBox(
                                                  width: 80, 
                                                  height: 80,
                                                  child: FlatButton (
                                                    shape:RoundedRectangleBorder(
                                                        borderRadius: new BorderRadius.circular(40.0),
                                                        side: BorderSide(color: Colors.black38)
                                                      ),
                                                    onPressed: (){
                                                      _takeOne(f.id, f.size,f.number, f.nome, f.image);
                                                    },
                                                    color: Colors.redAccent,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 3, top: 3, bottom: 3, left: 3) ,
                                                        child:Image.network(
                                                          'https://image.flaticon.com/icons/png/512/26/26422.png',
                                                              width: 40,
                                                              height: 40,
                                                              color: Colors.white,
                                                          ),
                                                       ),
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
                                                         Navigator.push(
                                                              context,
                                                              MaterialPageRoute(builder: (context) => EditMed(id : f.id, name : f.nome, number: f.number, size : f.size, image: f.image,)),
                                                            ).then( (Null){
                                                              initState();
                                                            });
                                                    },
                                                    color: Colors.green,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 3, top: 3, bottom: 3, left: 3) ,
                                                        child: Icon(Icons.settings, color: Colors.white,size: 40.0,),
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
              color : Colors.redAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.redAccent)
                ),
               onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QR(lng : lng)),
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
                  backgroundColor: Color.fromRGBO(224,255,255, 1.0),
                  body: Center(
                        child: Text(
                            (lng == "pt" ?  'Não tem medicamentos': 'No medicines'),
                             textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black54),
                                                  
                        ),
                    ),
         );
        }else{
          return Scaffold(

           floatingActionButton: RaisedButton (
              elevation:5.0,
              color : Colors.redAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.redAccent)
                ),
               onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QR(lng : lng)),
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
                   backgroundColor: Color.fromRGBO(224,255,255, 1.0),
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





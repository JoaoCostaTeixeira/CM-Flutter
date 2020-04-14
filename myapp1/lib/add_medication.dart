import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'model/medicationList.dart';
import 'model/med.dart';

class QR extends StatelessWidget {

  String lng;
  QR ({ @required this.lng}); 
 
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
                 title: new Text( (lng == "pt" ? "Adicionar Medicamento" : "Add Medication")),
                 backgroundColor: Colors.redAccent,),

      body: QRSample(lng : lng),
    );
  }
}

class QRSample extends StatefulWidget {
  String lng;
   QRSample ({ @required this.lng}); 
  @override
  State<QRSample> createState() => QRSampleState(lng : lng);
}

class QRSampleState extends State<QRSample> {
  String lng; 
   QRSampleState ({ @required this.lng}); 
 String barcode = "";
  String image = "";
 ListMed m = new ListMed();


 String nome ="";
 int comp = 0;
 int size = 0;
 
 bool qrbode = false;
   List<Medicat> houseList= [];
  final dbHelper = DatabaseHelper3.instance;
    

     void _takePhoto() async {
      
    }

  
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
                    size: row ['size'],
                    image: row['image'],
                    number : row ['number'],
                  ),
                );
              });
              
            });
          }

     _addMed() async{
       bool exist = false;
       int ids = 0;
       int com = 0;
       int n = 0;
        if(nome != " "){
          _query().then(
            (Null){
                houseList.forEach(
                  (f){
                    if(f.nome == nome){
                      exist = true;
                      ids = f.id;
                      com = f.number;
                      n=f.size;
                    }
                  }
                );
                if(exist){
                    Map<String, dynamic> row = {
                          DatabaseHelper3.columnId : ids,
                          DatabaseHelper3.columnName : nome,
                          DatabaseHelper3.columnImage  : image,
                          DatabaseHelper3.columnNumber : comp+com,
                          DatabaseHelper3.columnSize : n,
                        };

                    dbHelper.update(row).then(
                      (Null){
                        Navigator.pop(context);
                      }
                    );
                }else{
                     Map<String, dynamic> row = {
                          DatabaseHelper3.columnName : nome,
                          DatabaseHelper3.columnImage  : image,
                          DatabaseHelper3.columnNumber : comp,
                          DatabaseHelper3.columnSize : size,
                        };
                    dbHelper.insert(row).then(
                      (Null) {
                          Navigator.pop(context);
                      }
                    );
                    
                }
            }
          );
               
        }else{
             showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text((lng == "pt" ? "Por favor adicione um nome ao medicamento": "Please add a name to the medicine")),
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

  @override
  Widget build(BuildContext context) {

    if(qrbode){
      print(nome);

      return Scaffold(
      resizeToAvoidBottomPadding: false,
        body:   
        new Center(
          child:
          
           new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                            Padding(
                  padding: const EdgeInsets.only(top:13, left: 10, right: 10, bottom: 10),
                  child:Text(
                      (lng=="pt" ? "Medicamento" : "Medicine"),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
                  ),
                ),

              Padding(
                          padding: const EdgeInsets.only(top:5, left: 10, right: 10, bottom: 5),
                          child:new TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: nome,
                                hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),

                              ),
                         ),
                        ),
                Padding(
                  padding: const EdgeInsets.only(top:5, left: 10, right: 10, bottom: 5),
                  child:
                  Container(
                    width: 350,
                    height: 69,
                       decoration: BoxDecoration(
                         borderRadius: new BorderRadius.circular(5.0),
                        color: Colors.transparent,
                        border: Border(
                            left: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, .15),
                                width: 1,
                            ),

                           right: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, .15),
                                width: 1,
                            ),
                            top: BorderSide(
                               color: Color.fromRGBO(0, 0, 0, .15),
                                width: 1,
                            ),
                            bottom: BorderSide(
                                color: Color.fromRGBO(0, 0, 0, .15),
                                width: 1,
                            ), 
                          ),
                        ),
                    child: Row(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child:  
                      Text(
                        comp.toString() +  (lng=="pt" ? " comprimidos" : " tablets"),
                        style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                      ),),
                     Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child:  
                     ButtonTheme(
                      minWidth: 30.0,
                      height: 30.0,
                      child:  RaisedButton(
                        elevation: 5.0,
                        color : Colors.deepOrange,
                        onPressed: (){
                              setState(() {
                                comp++;
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top:5, left: 5, right: 5, bottom: 5),
                          child: new Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20.0,
                              ),
                        ),
                    ),
                    ),),

                     Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child:  
                     ButtonTheme(
                      minWidth: 30.0,
                      height: 30.0,
                      child:  RaisedButton(
                        elevation: 5.0,
                        color : Colors.deepOrange,
                        onPressed: (){
                          setState(() {
                            comp--;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top:5, left: 5, right: 5, bottom: 5),
                          child: new Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 20.0,
                              ),
                        ),
                    ),
                    ),),

                    



                    ],
                    ),
                  )
                ),
                Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0,top: 5.0, bottom: 5),
                child: new Image.network(
                                         image,
                                          width: 250,
                                          height: 250,
                                      ),
              ),
             Padding(
              padding: const EdgeInsets.only(left:20,bottom: 5, top: 5, right: 10),
              child: RaisedButton (
                  elevation:5.0,
                  color : Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)
                    ),
                  onPressed: () {
                          _addMed();
                    },
                    child: Padding(
                            padding: const EdgeInsets.all(10),
                                child:  Text(
                                    (lng=="pt" ? "Guardar" : "Save"),
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                    )
                      ),
                ),
            ),
            new Spacer(),
              ],
          ),
        ));
    }else{
        return Scaffold(
      resizeToAvoidBottomPadding: false,
        body: 
          
        new Center(
          child:
          
           new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                            Padding(
                  padding: const EdgeInsets.only(top:13, left: 10, right: 10, bottom: 5),
                  child:Text(
                      (lng=="pt" ? "Medicamento sem QRCode" : "Medication without QRCode"),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),
                  ),
                ),

              Padding(
                  padding: const EdgeInsets.only(top:5, left: 10, right: 10, bottom: 5),
                  child:TextFormField(
                  decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText:  (lng=="pt" ? "Nome" : "Name"),
                      ),
                      onChanged:  (text){
                    setState(() {
                      nome = text;
                    });
                  },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:5, left: 10, right: 10, bottom: 5),
                  child:TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText:(lng=="pt" ?  'Número de Comprimidos por Caixa' : "Number of Tablets per Box"),
                        
                      ),
                      onChanged:  (text){
                    setState(() {
                      size = int.parse(text);
                    });
                  },
                  ),
                ),
                Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0,top: 5.0, bottom: 5),
                child: RaisedButton(
                    color: Colors.redAccent,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: (){
                        _takePhoto();
                    },
                    child:Padding(
                        padding: const EdgeInsets.only(top:10, left: 10, right: 10, bottom: 10),
                        child: new Icon(
                                        Icons.photo,
                                           color: Colors.white,
                                            size: 95.0,
                                      ),
                      ),
                ),
              ),
             Padding(
                              padding: const EdgeInsets.only(left:20,bottom: 10, top: 10, right: 10),
                              child: RaisedButton (
                                  elevation:5.0,
                                  color : Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.red)
                                    ),
                                  onPressed: () {
                                      setState(() {
                                            image = "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/once-a-month-contraceptive-pill-1575631448.jpg";
                                            qrbode = true;
                                            comp = size;
                                        });
                                    },
                                    child: Padding(
                                            padding: const EdgeInsets.all(10),
                                                child:  Text(
                                                    (lng=="pt" ?  'Guardar' : "Save"),
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                                    )
                                      ),
                                ),
                            ),
                 Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 9.0),
                  child: Container(
                    width: 135,
                    height: 4,
                    color: Colors.red,
                    child: new Text(""),
                  ),),

                   Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 15.0, ),
                  child: Container(
                    width: 30,
                    height: 30,
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.only(top:2 ),
                      child: Text(
                             (lng=="pt" ?  'Ou' : "Or"),
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),
                            )
                    ),
                    
                    
                  ),),

                   Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 15.0, right: 9.0),
                  child: Container(
                    width: 135,
                    height: 4,
                    color: Colors.red,
                    child: new Text(""),
                  ),),
              ],),


                 Padding(
                  padding: const EdgeInsets.only(top:5, left: 10, right: 10, bottom: 5),
                  child:Text(
                     (lng=="pt" ?   "Medicamento com QRCode" : "Medication with QRCode"),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.black),
                  ),
                ),

              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0,top: 10),
                child: RaisedButton(
                    color: Colors.redAccent,
                    textColor: Colors.white,
                    splashColor: Colors.blueGrey,
                    onPressed: scan,
                    child:Padding(
                        padding: const EdgeInsets.only(top:10, left: 10, right: 10, bottom: 10),
                        child: new Image.network(
                                         'https://pngimage.net/wp-content/uploads/2018/06/qr-code-icon-png-8.png',
                                         color: Colors.white,
                                          width: 130,
                                          height: 130,
                                      ),
                      ),
                ),
              ),
              new Spacer(),
            ],
          ),
        ));
  }

    }
    
        Future scan() async {
          try {
            String barcode = await BarcodeScanner.scan();
            
             m.getOne(int.parse(barcode)).then(
               (c){
                    setState(() {
                      print(c.name);
                      nome = c.name;
                      image = c.image;
                      comp = c.size;
                      size = c.size;
                      qrbode = true;
                    });
               }
             );
            
         
          } on PlatformException catch (e) {
            if (e.code == BarcodeScanner.CameraAccessDenied) {
              setState(() {
                this.barcode = 'The user did not grant the camera permission!';
              });
            } else {
              setState(() => this.barcode = 'Unknown error: $e');
            }
          } on FormatException{
            setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
          } catch (e) {
            setState(() => this.barcode = 'Unknown error: $e');
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




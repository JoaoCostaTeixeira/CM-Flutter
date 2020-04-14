import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'model/house.dart';
import 'model/med.dart';
import 'model/medicationShop.dart';
class EditMed extends StatelessWidget {

  String name;
  String image;
  int id;
  int size;
  int number;

  EditMed ({ @required this.name, @required this.image, @required this.id, @required this.size,  @required this.number});

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
                 backgroundColor: Colors.redAccent,),

      body: EditMedSample(name : name, image: image, size: size, number:number,id:id),
    );
  }
}

class EditMedSample extends StatefulWidget {
  String name;
  String image;
  int id;
  int size;
  int number;

  EditMedSample ({ @required this.name, @required this.image, @required this.id, @required this.size,  @required this.number});

  @override
  State<EditMedSample> createState() => EditMedSampleState(name : name, image:image, number:number, size:size,id: id);
}

class EditMedSampleState extends State<EditMedSample> {
  String name;
  String image;
  int id;
  int size;
  int number;
  bool isOn = false;

  List<Medicat> medHop = [];
  

  EditMedSampleState ({ @required this.name, @required this.image, @required this.id, @required this.size,  @required this.number});

  final dbHelper = DatabaseHelper3.instance;
  final dbHelper2 = DatabaseHelper4.instance;

 _addMed() async{
    
      Map<String, dynamic> row = {
            DatabaseHelper3.columnId : id,
            DatabaseHelper3.columnName : name,
            DatabaseHelper3.columnImage  : image,
            DatabaseHelper3.columnNumber : number,
            DatabaseHelper3.columnSize : size,
          };

          dbHelper.update(row).then(
            (Null){
              Navigator.pop(context);
            }
          );
    }

    _deleteMed() async {
      dbHelper.delete(id).then((Null){
          Navigator.pop(context);
      });
    }


       _query2() async {
          final allRows = await dbHelper2.queryAllRows();
          print('query all rows:');
          allRows.forEach((row) {

              if(row['image']== image &&  row['nome'] == name){
                setState(() {
                  isOn=true;
                });
           
              }
          
            
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
    _query2();
  }







  @override
  Widget build(BuildContext context) {
   return Scaffold(
        body:   
        SingleChildScrollView(
          
          child: Center(
          child: Column (
              mainAxisAlignment: MainAxisAlignment.start,
              children:<Widget>[
                  Padding(
                  padding: const EdgeInsets.only(top:13, left: 10, right: 10, bottom: 10),
                  child:Text(
                      "Medicamento",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
                  ),
                ),
                 Padding(
                          padding: const EdgeInsets.only(top:5, left: 10, right: 10, bottom: 5),
                          child:new TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: name,
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
                        number.toString() + " comprimidos",
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
                                number++;
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
                            number--;
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
                    child:
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child:  
                      Text(
                        size.toString() + " comprimidos por caixa",
                        style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                      ),),
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

                 Row(children: <Widget>[
                   Padding(
              padding: const EdgeInsets.only(left:40,bottom: 5, top: 5, right: 10),
              child: RaisedButton (
                  elevation:5.0,
                  color : Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.green)
                    ),
                  onPressed: () {
                         _addMed();
                    },
                    child: Padding(
                            padding: const EdgeInsets.all(10),
                                child:  Text(
                                    "Guardar",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                    )
                      ),
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
                         _deleteMed();
                    },
                    child: Padding(
                            padding: const EdgeInsets.all(10),
                                child:  Text(
                                    "Remover",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                    )
                      ),
                ),
            ),
              ],),

            (isOn? Text('')
            :
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
                      _addToShop(size, name, image);
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
                ),) 
            ),
              ],
          ),
        )
        )
   );
        
  
  }

}


class Medicat {
  final String nome;
  final String image;

  Medicat({ this.nome,this.image});

}

import 'package:flutter/material.dart';
import 'package:myapp1/model/farmaciaFav.dart';
import 'map.dart';
import 'alarms.dart';
import 'settings.dart';
import 'farmacias.dart';
import 'house.dart';
import 'shop.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'medicationPage.dart';

import 'model/house.dart';
import 'model/alarme.dart';


void main() =>runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          
        primarySwatch: Colors.blue,
      ),
      
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

                
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    String casos = "";
    String novos = "";
    String mortes = "";
    bool hide = true;
    bool loading = true;
    String lng;

     final dbHelper1 = DatabaseHelper1.instance;
     final dbHelper2 = DatabaseHelper2.instance;

    Future<Corona> fetchFarmacia() async {
      final response =
          await http.get('https://corona.lmao.ninja/all');
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        return Corona.fromJson(json.decode(response.body));
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    }

    Future getPrefs() async{ 
      await SharedPreferences.getInstance().then((prefs){
          print ('prefs pls');
           setState(() {
              lng = prefs.getString("linguagem") ?? "pt";
              print(lng);
              
           });
      });
      

    }

 
     @override
     void initState() {
         fetchFarmacia().then(
           (corona){
             setState(() {
               casos = corona.cases.toString();
               novos = corona.recovered.toString();
               mortes = corona.deaths.toString();
             });
           }
          );
          
         getPrefs().then((Null){
            dbHelper1.create().then((Null){ //BAse de dados CAsas
                dbHelper2.create().then((Null){ // Base de dados alarmes
                    setState(() {
                        loading = false;
                    });
              });
            });
          
         });

     }

    @override
    Widget build(BuildContext context) {
        if(loading){
            return  Scaffold(
              backgroundColor: Color.fromRGBO(128, 128, 255,1),
              body:Center(
                child: 
                Padding(
                   padding: const EdgeInsets.only(top:300) ,
                  child:Container(
                  child: Column(children: <Widget>[
                    Image.asset(
                      'assets/images/logo.png',
                      height: 80.0,
                      width: 80.0,
                    ),
                    Text('BetterDose',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Color.fromRGBO(81,52,139, 1)),),
                ],),
                ),
                ),
              ), 
            );
        }else{
            if(hide){
            return Scaffold(
            backgroundColor: Color.fromARGB(250, 245, 245, 245),
            
            body: Column(
              children: <Widget>[
                Container(
                    height: 110,
                    child:Row(children: <Widget>[
                    Padding(
                    padding: const EdgeInsets.only(left: 20, top:20) ,
                    
                    child:
                    SizedBox(
                        width: 80, 
                        height: 45,// specific value
                        
                        child: FlatButton (
                          
                          shape:RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.1),
                              side: BorderSide(color: Colors.black38)
                            ),
                          onPressed:() {
                              setState(() {
                                hide = false;
                              });
                          },
                          color: Colors.redAccent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 2, top: 2, bottom: 2) ,
                              child:Row(children: <Widget>[
                                Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                    size: 30.0,
                                  ), 
                            Padding(
                              padding: const EdgeInsets.only(right: 2) ,
                              child:           
                                Text(
                                  '1',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23, color: Colors.white),),),
                              ],) ),
                            ],
                          ), 
                      ),
                      ), 
                    ),
                    ],),
                ),
                
              Center(
                child:     
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children:[ 
                    Center(  child:
                      Row( 
                        mainAxisAlignment: MainAxisAlignment.center,

                        children:[
                          Padding(
                              padding: const EdgeInsets.all(15),

                              // Button 
                              child: new RaisedButton(
                                elevation:5.0,
                                color : Colors.orangeAccent,
                              onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Alarms()),
                                    );
                                  },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                          Padding(
                                            padding: EdgeInsets.only(top:10, left: 10, right: 10),
                                            child: new Icon(
                                                      Icons.timer,
                                                      color: Colors.white,
                                                      size: 95.0,
                                                    ),
                                          ),
                                        Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Text(
                                                    (lng =='pt' ? 'Alarme' : 'Alarm'),
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                                  )
                                          ),
                                      ]
                              ),
                            ),                              
                          ), 
                          
                          Padding(
                              padding: EdgeInsets.all(15),

                              // Button 
                              child: new RaisedButton(
                                elevation:5.0,
                                color : Colors.lightGreen,
                              onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (BuildContext context) => Houses()),
                                    );
                                  },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                          Padding(
                                            padding: const EdgeInsets.only(top:10, left: 10, right: 10),
                                            child: new Icon(
                                                      Icons.store_mall_directory,
                                                      color: Colors.white,
                                                      size: 95.0,
                                                    ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Text(
                                                   (lng =='pt' ? 'Casa' : 'House'),
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                                  )
                                          ),
                                      ]
                              ),
                            ),                              
                          ), 
                        ]
                      ),
                    ),
                    Center(  child:
                      Row( 
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                            Padding(
                              padding: EdgeInsets.all(15),

                              //Button
                              child: new RaisedButton(
                                elevation:5.0,
                                color : Colors.lightBlue,
                               /* onPressed: () {
                                  initState();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Shop()),
                                    );
                                },*/
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                          Padding(
                                            padding: EdgeInsets.only(top:10, left: 10, right: 10),
                                            child: new Icon(
                                                      Icons.shopping_cart,
                                                      color: Colors.white,
                                                      size: 95.0,
                                                    ),
                                          ),
                                          
                                        Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Text(
                                                    (lng =='pt' ? 'Compras' : 'Shop'),
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                                  )
                                          ),
                                      ]
                              ),
                            ),                              
                          ), 
                          Padding(
                              padding: EdgeInsets.all(15),

                              //Button
                              child: new RaisedButton(
                                elevation:5.0,
                                color : Colors.blueGrey,
                                onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (BuildContext context) => Farmacias()),
                                    );
                                },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                          Padding(
                                            padding: const EdgeInsets.only(top:10, left: 10, right: 10),
                                            child: new Icon(
                                                      Icons.local_hospital,
                                                      color: Colors.white,
                                                      size: 95.0,
                                                    ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Text(
                                                     (lng =='pt' ? 'Farmácia' : 'Pharmacy'),
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                                  )
                                          ),
                                    ]
                              ),
                            ),                              
                          ), 
                        ]
                      ),
                    ),
                    Center(  child:
                      Row( 
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Padding(
                              padding: EdgeInsets.all(15),

                              //Button
                              child: new RaisedButton(
                                elevation:5.0,
                                color : Colors.redAccent,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (BuildContext context) => Medication()),
                                    );
                                },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                          Padding(
                                            padding: const EdgeInsets.only(top:10, left: 10, right: 10),
                                            child: new Icon(
                                                      Icons.person,
                                                      color: Colors.white,
                                                      size: 95.0,
                                                    ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Text(
                                                     (lng =='pt' ? 'Medicamentos' : 'Medicin'),
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
                                                  )
                                          ),
                                    ]
                              ),
                            ),                              
                          ), 
                          Padding(
                              padding: EdgeInsets.all(15),

                              //Button
                              child: new RaisedButton(
                                elevation:5.0,
                                color : Colors.purpleAccent,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Settings(lng : lng)),
                                    ).then( (Null){
                                      print("oioioioioiasd");
                                     initState();
                                    }
                                    );
                                  },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                          Padding(
                                            padding: const EdgeInsets.only(top:10, left: 10, right: 10),
                                            child: new Icon(
                                                      Icons.settings,
                                                      color: Colors.white,
                                                      size: 95.0,
                                                    ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Text(
                                                    (lng =='pt' ? 'Definições' : 'Settings'),
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                                  )
                                          ),
                                    ]
                              ),
                            ),                              
                          ), 
                        ]
                      ),
                    ),
                  ]
                ),
            ),

              ],
              
              )
                
        );
        }else{
          return Scaffold(
            backgroundColor: Color.fromARGB(250, 245, 245, 245),
            
            body: 
                Center(
                child:     
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children:[

                      Container(
                                  padding: const EdgeInsets.only(top:10),
                                  height: 160,
                                  width:350,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.redAccent,
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
                                              (lng =='pt' ? 'Covid-19 Atualização' : 'Covid-19 Update '),
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ) ,
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:7, top: 7) ,
                                                    child: 
                                                    
                                                    Text(
                                                        'Total: ' + casos,
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left:7,  top: 7) ,
                                                    child: 
                                                    
                                                    Text(
                                                      (lng =='pt' ? 'Mortes: ' : 'Deaths: ') + mortes,
                                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                  )
                                                  
                                                
                                                ],
                                            ),
                                            Text(
                                               (lng =='pt' ? 'Fique em casa' : 'Stay Home'),
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
                                              textAlign: TextAlign.center,
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
                                                    onPressed: () => launch("tel://808242424"),
                                                    color: Colors.transparent,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10) ,
                                                        child: Icon(
                                                                      Icons.call,
                                                                      color: Colors.white,
                                                                      size: 25.0,
                                                                    ), ),
                                                      
                                                        Text(
                                                            'SNS24',
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
                                                      setState(() {
                                                        hide = true;
                                                      });
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
                                                            'Hide',
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

                    Center(  child:
                      Row( 
                        mainAxisAlignment: MainAxisAlignment.center,

                        children:[
                          Padding(
                              padding: const EdgeInsets.all(15),

                              // Button 
                              child: new RaisedButton(
                                elevation:5.0,
                                color : Colors.orangeAccent,
                              onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Alarms()),
                                    );
                                  },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                          Padding(
                                            padding: EdgeInsets.only(top:10, left: 10, right: 10),
                                            child: new Icon(
                                                      Icons.timer,
                                                      color: Colors.white,
                                                      size: 95.0,
                                                    ),
                                          ),
                                        Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Text(
                                                    (lng =='pt' ? 'Alarme' : 'Alarm'),
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                                  )
                                          ),
                                      ]
                              ),
                            ),                              
                          ), 
                          
                          Padding(
                              padding: EdgeInsets.all(15),

                              // Button 
                              child: new RaisedButton(
                                elevation:5.0,
                                color : Colors.lightGreen,
                              onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (BuildContext context) => Houses()),
                                    );
                                  },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                          Padding(
                                            padding: const EdgeInsets.only(top:10, left: 10, right: 10),
                                            child: new Icon(
                                                      Icons.store_mall_directory,
                                                      color: Colors.white,
                                                      size: 95.0,
                                                    ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Text(
                                                    (lng =='pt' ? 'Casa' : 'House'),
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                                  )
                                          ),
                                      ]
                              ),
                            ),                              
                          ), 
                        ]
                      ),
                    ),
                    Center(  child:
                      Row( 
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                            Padding(
                              padding: EdgeInsets.all(15),

                              //Button
                              child: new RaisedButton(
                                elevation:5.0,
                                color : Colors.lightBlue,
                                onPressed: () {
                                  initState();
                                },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                          Padding(
                                            padding: EdgeInsets.only(top:10, left: 10, right: 10),
                                            child: new Icon(
                                                      Icons.shopping_cart,
                                                      color: Colors.white,
                                                      size: 95.0,
                                                    ),
                                          ),
                                          
                                        Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Text(
                                                    (lng =='pt' ? 'Compras' : 'Shop'),
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                                  )
                                          ),
                                      ]
                              ),
                            ),                              
                          ), 
                          Padding(
                              padding: EdgeInsets.all(15),

                              //Button
                              child: new RaisedButton(
                                elevation:5.0,
                                color : Colors.blueGrey,
                                onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (BuildContext context) => Farmacias()),
                                    );
                                },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                          Padding(
                                            padding: const EdgeInsets.only(top:10, left: 10, right: 10),
                                            child: new Icon(
                                                      Icons.local_hospital,
                                                      color: Colors.white,
                                                      size: 95.0,
                                                    ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Text(
                                                   (lng =='pt' ? 'Farmácia' : 'Pharmacy'),
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                                  )
                                          ),
                                    ]
                              ),
                            ),                              
                          ), 
                        ]
                      ),
                    ),
                    Center(  child:
                      Row( 
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Padding(
                              padding: EdgeInsets.all(15),

                              //Button
                              child: new RaisedButton(
                                elevation:5.0,
                                color : Colors.redAccent,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (BuildContext context) => Medication()),
                                    );
                                },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                          Padding(
                                            padding: const EdgeInsets.only(top:10, left: 10, right: 10),
                                            child: new Icon(
                                                      Icons.person,
                                                      color: Colors.white,
                                                      size: 95.0,
                                                    ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Text(
                                                    (lng =='pt' ? 'Medicamentos' : 'Medicin'),
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
                                                  )
                                          ),
                                    ]
                              ),
                            ),                              
                          ), 
                          Padding(
                              padding: EdgeInsets.all(15),

                              //Button
                              child: new RaisedButton(
                                elevation:5.0,
                                color : Colors.purpleAccent,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Settings(lng : lng)),
                                    ).then( (Null){
                                      print("oioioioioiasd");
                                      initState();
                                    }
                                    );
                                  },
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[  
                                          Padding(
                                            padding: const EdgeInsets.only(top:10, left: 10, right: 10),
                                            child: new Icon(
                                                      Icons.settings,
                                                      color: Colors.white,
                                                      size: 95.0,
                                                    ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Text(
                                                    (lng =='pt' ? 'Definições' : 'Settings'),
                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                                  )
                                          ),
                                    ]
                              ),
                            ),                              
                          ), 
                        ]
                      ),
                    ),
                  ]
                ),
            ),
        );
        }
      }
   }

      
  }



class Corona {
  final int cases;
  final int recovered;
  final int deaths;

  Corona({this.cases, this.recovered, this.deaths});

  factory Corona.fromJson(Map<String, dynamic> json) {

    return Corona(
      cases : json['cases'],
      recovered: json['recovered'],
      deaths: json['deaths'],
    );
  }
}


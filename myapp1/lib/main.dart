import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'map.dart';
import 'alarms.dart';
import 'farmacias.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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
    bool hide = false;
        
    Future<Corona> fetchFarmacia() async {
      final response =
          await http.get('https://corona.lmao.ninja/countries/PT');
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
 
     @override
     void initState() {
        print("oioi");
         fetchFarmacia().then(
           (corona){
             print(corona.country);
             setState(() {
               hide = true;
               casos = corona.cases.toString();
               novos = corona.todayCases.toString();
               mortes = corona.deaths.toString();
             });
           }
          );
     }

    @override
    Widget build(BuildContext context) {


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
                            borderRadius: new BorderRadius.circular(0.0),
                            side: BorderSide(color: Colors.black38)
                          ),
                        onPressed:() {
                            setState(() {
                              hide = false;
                            });
                        },
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 2, top: 2, bottom: 2) ,
                            child: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                          size: 30.0,
                                        ), ),
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
                                                  'Alarme',
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
                                                  'Compras',
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

                            // Button 
                            child: new RaisedButton(
                              elevation:5.0,
                              color : Colors.lightGreen,
                             onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (BuildContext context) => MyMap()),
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
                                                  'Mapa',
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
                                                    Icons.local_pharmacy,
                                                    color: Colors.white,
                                                    size: 95.0,
                                                  ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Text(
                                                  'Farmácia',
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
                              onPressed: () {},
                              child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children:[
                                        Padding(
                                          padding: const EdgeInsets.only(top:10, left: 10, right: 10),
                                          child: new Icon(
                                                    Icons.home,
                                                    color: Colors.white,
                                                    size: 95.0,
                                                  ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Text(
                                                  'Armazem',
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
                              color : Colors.purpleAccent,
                              onPressed: () {},
                              child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children:[
                                        Padding(
                                          padding: const EdgeInsets.only(top:10, left: 10, right: 10),
                                          child: new Icon(
                                                    Icons.notification_important,
                                                    color: Colors.white,
                                                    size: 95.0,
                                                  ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Text(
                                                  'Notificações',
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
                                            'Corona Update',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ) ,
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(left:7, top: 8) ,
                                                  child: 
                                                  
                                                  Text(
                                                      'Total: ' + casos,
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left:7,  top: 8) ,
                                                  child: 
                                                  
                                                   Text(
                                                      'Novos: ' + novos,
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                ),
                                                 Padding(
                                                  padding: const EdgeInsets.only(left:7,  top: 8) ,
                                                  child: 
                                                  
                                                   Text(
                                                      'Mortes: ' + mortes,
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                )
                                                
                                              
                                              ],
                                          ),
                                          Text(
                                            'Fique em casa',
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
                                                  'Alarme',
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
                                                  'Compras',
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

                            // Button 
                            child: new RaisedButton(
                              elevation:5.0,
                              color : Colors.lightGreen,
                             onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (BuildContext context) => MyMap()),
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
                                                  'Mapa',
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
                                                    Icons.local_pharmacy,
                                                    color: Colors.white,
                                                    size: 95.0,
                                                  ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Text(
                                                  'Farmácia',
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
                              onPressed: () {},
                              child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children:[
                                        Padding(
                                          padding: const EdgeInsets.only(top:10, left: 10, right: 10),
                                          child: new Icon(
                                                    Icons.home,
                                                    color: Colors.white,
                                                    size: 95.0,
                                                  ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Text(
                                                  'Armazem',
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
                              color : Colors.purpleAccent,
                              onPressed: () {},
                              child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children:[
                                        Padding(
                                          padding: const EdgeInsets.only(top:10, left: 10, right: 10),
                                          child: new Icon(
                                                    Icons.notification_important,
                                                    color: Colors.white,
                                                    size: 95.0,
                                                  ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Text(
                                                  'Notificações',
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



class Corona {
  final String country;
  final int cases;
  final int todayCases;
  final int deaths;


  Corona({ this.country, this.cases, this.todayCases, this.deaths});

  factory Corona.fromJson(Map<String, dynamic> json) {

    return Corona(
      country : json['country'],
      cases : json['cases'],
      todayCases: json['todayCases'],
      deaths: json['deaths'],
    );
  }
}


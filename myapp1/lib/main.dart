import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'map.dart';
import 'alarms.dart';
import 'farmacias.dart';
void main(){
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
} 

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

    @override
    Widget build(BuildContext context) {
      return Scaffold(
          backgroundColor: Color.fromARGB(250, 245, 245, 245),
          
          body: 
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
                              onPressed: () {},
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



  

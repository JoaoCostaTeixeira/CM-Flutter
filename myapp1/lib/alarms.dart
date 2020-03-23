import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(Alarms());




class Alarms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(250, 245, 245, 245),
          appBar: new AppBar(
                 title: new Text("Alarmes"),
                 backgroundColor: Colors.orangeAccent,),

      body: AlarmsSample(),
    );
  }
}
 bool isSwitched = true;

class AlarmsSample extends StatefulWidget {
  @override
  State<AlarmsSample> createState() => AlarmsSampleState();
}

class AlarmsSampleState extends State<AlarmsSample> {

  @override
  Widget build(BuildContext context) {
      
    
    return Scaffold(
       floatingActionButton: RaisedButton (
              elevation:5.0,
              color : Colors.orangeAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.orangeAccent)
                ),
               onPressed: () {
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
          body: new ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget> [
                  Padding(
                      padding: const EdgeInsets.only(top:10, bottom: 10),
                      child: 
                      new GestureDetector(
                          onTap: (){
                              print("Container clicked");
                            },
                        child:Container(
                          padding: const EdgeInsets.all(8),
                          height: 80,
                          color:Color.fromARGB(100, 255, 250, 230),
                          child: Row(
                            children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          '11:11',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black54),
                                        
                                        ),
                                        Text(
                                          'Todos os dias',
                                        )
                                      ],
                                    ),
                                      new Spacer(),
                                      Switch(
                                        value: isSwitched,
                                        onChanged: (value) {
                                        },
                                        activeTrackColor: Colors.orangeAccent, 
                                        activeColor: Colors.orange,
                                      ),
                            ],
                          ),
                          ),
                      ),
            ),
              Padding(
                      padding: const EdgeInsets.only(top:10, bottom: 10),
                      child: 
                      new GestureDetector(
                          onTap: (){
                              print("Container clicked");
                            },
                        child:Container(
                          padding: const EdgeInsets.all(8),
                          height: 80,
                          color:Color.fromARGB(100, 255, 250, 230),
                          child: Row(
                            children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          '11:11',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black54),
                                        
                                        ),
                                        Text(
                                          'Todos os dias',
                                        )
                                      ],
                                    ),
                                      new Spacer(),
                                      Switch(
                                        value: isSwitched,
                                        onChanged: (value) {
                                        },
                                        activeTrackColor: Colors.orangeAccent, 
                                        activeColor: Colors.orange,
                                      ),
                            ],
                          ),
                          ),
                      ),
            ),
              Padding(
                      padding: const EdgeInsets.only(top:10, bottom: 10),
                      child: 
                      new GestureDetector(
                          onTap: (){
                              print("Container clicked");
                            },
                        child:Container(
                          padding: const EdgeInsets.all(8),
                          height: 80,
                          color:Color.fromARGB(100, 255, 250, 230),
                          child: Row(
                            children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          '11:11',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black54),
                                        
                                        ),
                                        Text(
                                          'Todos os dias',
                                        )
                                      ],
                                    ),
                                      new Spacer(),
                                      Switch(
                                        value: isSwitched,
                                        onChanged: (value) {
                                        },
                                        activeTrackColor: Colors.orangeAccent, 
                                        activeColor: Colors.orange,
                                      ),
                            ],
                          ),
                          ),
                      ),
            ),
              Padding(
                      padding: const EdgeInsets.only(top:10, bottom: 10),
                      child: 
                      new GestureDetector(
                          onTap: (){
                              print("Container clicked");
                            },
                        child:Container(
                          padding: const EdgeInsets.all(8),
                          height: 80,
                          color:Color.fromARGB(100, 255, 250, 230),
                          child: Row(
                            children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          '11:11',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black54),
                                        
                                        ),
                                        Text(
                                          'Todos os dias',
                                        )
                                      ],
                                    ),
                                      new Spacer(),
                                      Switch(
                                        value: isSwitched,
                                        onChanged: (value) {
                                        },
                                        activeTrackColor: Colors.orangeAccent, 
                                        activeColor: Colors.orange,
                                      ),
                            ],
                          ),
                          ),
                      ),
            ),
              Padding(
                      padding: const EdgeInsets.only(top:10, bottom: 10),
                      child: 
                      new GestureDetector(
                          onTap: (){
                              print("Container clicked");
                            },
                        child:Container(
                          padding: const EdgeInsets.all(8),
                          height: 80,
                          color:Color.fromARGB(100, 255, 250, 230),
                          child: Row(
                            children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          '11:11',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black54),
                                        
                                        ),
                                        Text(
                                          'Todos os dias',
                                        )
                                      ],
                                    ),
                                      new Spacer(),
                                      Switch(
                                        value: isSwitched,
                                        onChanged: (value) {
                                        },
                                        activeTrackColor: Colors.orangeAccent, 
                                        activeColor: Colors.orange,
                                      ),
                            ],
                          ),
                          ),
                      ),
            ),
              Padding(
                      padding: const EdgeInsets.only(top:10, bottom: 10),
                      child: 
                      new GestureDetector(
                          onTap: (){
                              print("Container clicked");
                            },
                        child:Container(
                          padding: const EdgeInsets.all(8),
                          height: 80,
                          color:Color.fromARGB(100, 255, 250, 230),
                          child: Row(
                            children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          '11:11',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black54),
                                        
                                        ),
                                        Text(
                                          'Todos os dias',
                                        )
                                      ],
                                    ),
                                      new Spacer(),
                                      Switch(
                                        value: isSwitched,
                                        onChanged: (value) {
                                        },
                                        activeTrackColor: Colors.orangeAccent, 
                                        activeColor: Colors.orange,
                                      ),
                            ],
                          ),
                          ),
                      ),
            ),
            
                ]
              ),
    );

  }
}
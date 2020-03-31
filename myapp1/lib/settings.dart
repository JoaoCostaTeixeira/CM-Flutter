import 'dart:async';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class Settings extends StatelessWidget {
  @override
  String lng;
  Settings ({ @required this.lng}); 
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(250, 245, 245, 245),
      body: SettingsSample(lng : lng),
    );
  }
}
 bool isSwitched = true;

class SettingsSample extends StatefulWidget {
  String lng;
  SettingsSample ({ @required this.lng}); 
  @override
  State<SettingsSample> createState() => SettingsSampleState(lng2: lng);
}





/*
Future<LocationData> 
}*/

class SettingsSampleState extends State<SettingsSample> {
  
  String lng2;
 SettingsSampleState ({ @required this.lng2}); 

 bool switchbool = false;
  bool c = true;

  _switchChange (bool v){
      setState(() {
          switchbool = v;
    }); 
  }

  
     @override
     void initState() {
        if(lng2 == 'pt' ){
          setState(() {
            c=true;
          });
        }else{
           setState(() {
            c=false;
          });
        }
     }

_changeNational (int i) async{
   await SharedPreferences.getInstance().then((prefs){
           if(i == 1){
             prefs.setString('linguagem', 'pt');
              setState(() {
                    c = true;
                    lng2 ="pt";
              });

            }else{
              prefs.setString('linguagem', 'en');
              setState(() {
                    c = false;
                    lng2 ="en";
              });
            }
      });
 
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
                 title:(lng2 =='pt' ?  new Text("Definições") :  new Text("Settings")),
                 backgroundColor: Colors.purpleAccent,),

      backgroundColor: Colors.black12,
      body: Column(
        children: <Widget>[
            Padding(
              padding: EdgeInsets.only( top:10),
                child:
              Container(
                    height: 90,
                    width:400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1.0, 2.0), //(x,y)
                          ),
                        ],
                      ),
                    child:  Row(children: <Widget>[
                      Padding(
                      padding: EdgeInsets.only(left: 10),
                        child:
                          Text(
                                (lng2=='pt' ? 'Tema Escuro' : 'DarkMode'),
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                                textAlign: TextAlign.center
                          ),
                    ),
                    new Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                        child:
                          Switch(value: switchbool, onChanged: (value){_switchChange(value);},
                    ),
                  
                    )]),
          ),
            ),
         Padding(
              padding: EdgeInsets.only( top:10),
                child:

              Container(
                    height: 90,
                    width:400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1.0, 2.0), //(x,y)
                          ),
                        ],
                      ),
                    child:  Row(children: <Widget>[
                      Padding(
                      padding: EdgeInsets.only(left: 10),
                        child:
                          Text(
                                (lng2=='pt' ? 'Linguagem' : 'Language'),
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                                textAlign: TextAlign.center
                          ),
                    ),
                    new Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                        child:
                          new GestureDetector(
                          onTap: (){
                              _changeNational(1);
                            },
                        child:
                         Container(
                              height: 45,
                              width:50,
                             decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: c==true ? Colors.red : Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(1.0, 2.0), //(x,y)
                                    ),
                                  ],
                                ),
                           child:Image.asset(
                                      'assets/images/pt.png',
                                      height: 100.0,
                                      width: 100.0,
                                    ),
                         ),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10),
                        child:
                          new GestureDetector(
                          onTap: (){
                              _changeNational(0);
                            },
                        child:
                         Container(
                              height: 45,
                              width:50,
                             decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color:  c==true ? Colors.white : Colors.red,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(1.0, 2.0), //(x,y)
                                    ),
                                  ],
                                ),
                           child:Image.asset(
                                      'assets/images/en.jpg',
                                      height: 100.0,
                                      width: 80.0,
                                    ),
                         ),
                         
                    ),),
                  
                  ],),
          ),
            ),
         
           
         
        ],
      ),
    );
  }
}
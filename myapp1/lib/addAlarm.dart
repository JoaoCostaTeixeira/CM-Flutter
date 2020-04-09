import 'dart:isolate';

import 'package:flutter/material.dart';
import 'model/alarme.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'alarms.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(AlarmsAdd());


 void printHello() async{
   
   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  print("bo");
   var initializationSettingsAndroid = AndroidInitializationSettings('logo');
      var initializationSettings = InitializationSettings(initializationSettingsAndroid, null);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: selectNotification);
      var androidPlatformChannelSpecifics = AndroidNotificationDetails('2', 'aiai','your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');

    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, null);
      await flutterLocalNotificationsPlugin.show(
          0, 'plain title', 'plain body', platformChannelSpecifics,
          payload: 'item x');

 
  
 }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    print("carreguei");
    await Navigator.push(
      null,
      MaterialPageRoute(builder: (context) => Alarms()),
    );    
}
 
class AlarmsAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(250, 245, 245, 245),
          appBar: new AppBar(
                 title: new Text("Adicionar Alarme"),
                 backgroundColor: Colors.orangeAccent,),

      body: AlarmsAddSample(),
    );
  }
}
 bool isSwitched = true;

class AlarmsAddSample extends StatefulWidget {
  @override
  State<AlarmsAddSample> createState() => AlarmsAddSampleState();
}

class AlarmsAddSampleState extends State<AlarmsAddSample> {

  
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project

  bool seg = false;
  bool ter = false;
  bool qua = false;
  bool qui = false;
  bool sex = false;
  bool sab = false;
  bool dom = false;
  bool todos = false;
  
  int seg1 = 0;
  int ter1 = 0;
  int qua1 = 0;
  int qui1 = 0;
  int sex1 = 0;
  int sab1 = 0;
  int dom1 = 0;
  

  int hora = 12;
  int min = 12;

 


  final dbHelper = DatabaseHelper1.instance;
      _addAlarm() async{

        if(!seg && !ter && !qua && !qui && !sex && !sab && !dom){
             showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: new Text("Por favor adicione um dia da semana"),
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
          
        }else{


          Map<String, dynamic> row = {
                  DatabaseHelper1.columnHora : hora,
                  DatabaseHelper1.columnMin  : min,
                   DatabaseHelper1.columnSeg  : seg1,
                    DatabaseHelper1.columnTer  : ter1,
                     DatabaseHelper1.columnQua  : qua1,
                      DatabaseHelper1.columnQui  : qui1,
                       DatabaseHelper1.columnSex  : sex1,
                        DatabaseHelper1.columnSab  : sab1,
                         DatabaseHelper1.columnDom  : dom1,
                          DatabaseHelper1.columnActive  : 1,

                };

            final helloAlarmID = await dbHelper.insert(row);
            await AndroidAlarmManager.initialize();
            await AndroidAlarmManager.periodic(const Duration(minutes: 1), helloAlarmID, printHello);
            print('inserted row id: $helloAlarmID');
            Navigator.pop(context);
          }
    }

 void _value1Changed(bool value) {
   setState(() {
     seg = value;
     if(value){
       seg1=1;
     }else{
       seg1=0;
     }
   });
 } 

 void _value2Changed(bool value) {
   setState(() {
     ter = value;
     if(value){
       ter1=1;
     }else{
       ter1=0;
     }
   });
 } 

 void _value3Changed(bool value) {
   setState(() {
     qua = value;
     if(value){
       qua1=1;
     }else{
       qua1=0;
     }
   });
 } 

 void _value4Changed(bool value) {
   setState(() {
     qui = value;
     if(value){
       qui1=1;
     }else{
       qui1=0;
     }
   });
 } 

 void _value5Changed(bool value) {
   setState(() {
     sex = value;
     if(value){
       sex1=1;
     }else{
       sex1=0;
     }
   });
 } 

 void _value6Changed(bool value) {
   setState(() {
     sab = value;
     if(value){
       sab1=1;
     }else{
       sab1=0;
     }
   });
 } 

 void _value7Changed(bool value) {
   setState(() {
     dom = value;
     if(value){
       dom1=1;
     }else{
       dom1=0;
     }
   });
 } 

  void _value8Changed(bool value) {
   setState(() {
     todos = value;
     seg = value;
     ter = value;
     qua = value;
     qui = value;
     sex = value;
     sab = value;
     dom = value;
     if(value){
       seg1=1;
       ter1=1;
       qua1=1;
       qui1=1;
       sex1=1;
       sab1=1;
       dom1=1;
     }else{
       seg1=0;
       ter1=0;
       qua1=0;
       qui1=0;
       sex1=0;
       sab1=0;
       dom1=0;
     }
   });
 } 
  
  

void _damn (){
  print('fds');
}

  @override
    void initState() {
        AndroidAlarmManager.cancel(2).then((Null){
       print("ui");
      });
      
       AndroidAlarmManager.periodic(const Duration(seconds: 3), 2, printHello).then((Null){
       print("ui");
      });
}
  @override
  Widget build(BuildContext context) {
      
    if(todos){
        return SingleChildScrollView(
          child: Column(
                children: <Widget>[


                  Padding(
                      padding: const EdgeInsets.only(bottom: 5, top: 10, right: 10, left: 10),
                    child:  Container(
                     height: 200,
                      width:350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.orangeAccent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange,
                              offset: Offset(1.0, 2.0), //(x,y)
                            ),
                          ],
                        ),
                        child: 
                        Column(
                          children: <Widget>[
                               Row(
                                children: <Widget>[
                                 Container(
                                   width: 160,
                                   height: 200,
                                   child:  Column(

                                     children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.only(left:20,bottom: 10,top:20, right: 20),
                                            child:ButtonTheme(
                                                  minWidth: 30.0,
                                                  height: 30.0,
                                                  child:  RaisedButton(
                                                    elevation: 5.0,
                                                    color : Colors.deepOrange,
                                                    onPressed: (){
                                                        setState(() {
                                                        if(hora<23){
                                                          hora++;
                                                        }else{
                                                          hora =0;
                                                        }
                                                      });
                                                    },
                                                    child:  Padding(
                                                                padding: const EdgeInsets.only(top:5, left: 5, right: 5, bottom: 5),
                                                                child: new Icon(
                                                                          Icons.arrow_drop_up,
                                                                          color: Colors.white,
                                                                          size: 20.0,
                                                                        ),
                                                              ),
                                                ),
                                                )
                                          ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:20,bottom: 10,top:10, right: 20),
                                          child: Text(
                                                hora.toString(),
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                                )
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(left:20,bottom: 10,top:10, right: 20),
                                            child:ButtonTheme(
                                                  minWidth: 30.0,
                                                  height: 30.0,
                                                  child:  RaisedButton(
                                                    elevation: 5.0,
                                                    color : Colors.deepOrange,
                                                    onPressed: (){
                                                      setState(() {
                                                        if(hora>0){
                                                          hora--;
                                                        }else{
                                                          hora = 23;
                                                        }
                                                      });
                                                    },
                                                    child:  Padding(
                                                                padding: const EdgeInsets.only(top:5, left: 5, right: 5, bottom: 5),
                                                                child: new Icon(
                                                                          Icons.arrow_drop_down,
                                                                          color: Colors.white,
                                                                          size: 20.0,
                                                                        ),
                                                              ),
                                                ),
                                                )
                                          ),
                                     ],
                                   ),
                                  
                                 ),
                                  Container(
                                   width: 20,
                                   height: 200,
                                   child:   Padding(
                                        padding: const EdgeInsets.only(left:2,top:60,bottom: 60),
                                        child:
                                        Column(children: <Widget>[
                                            new Spacer(),
                                               Text(
                                              ":",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                                              ),
                                            new Spacer(),
                                        ],),
                                        
                                        
                                      ),
                                 ),
                                  Container(
                                   width: 160,
                                   height: 200,
                                   child:  Column(

                                     children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.only(left:20,bottom: 10,top:20, right: 20),
                                            child:ButtonTheme(
                                                  minWidth: 30.0,
                                                  height: 30.0,
                                                  child:  RaisedButton(
                                                    elevation: 5.0,
                                                    color : Colors.deepOrange,
                                                    onPressed: (){
                                                        setState(() {
                                                        if(min<59){
                                                          min++;
                                                        }else{
                                                          min = 0;
                                                        }
                                                      });
                                                    },
                                                    child:  Padding(
                                                                padding: const EdgeInsets.only(top:5, left: 5, right: 5, bottom: 5),
                                                                child: new Icon(
                                                                          Icons.arrow_drop_up,
                                                                          color: Colors.white,
                                                                          size: 20.0,
                                                                        ),
                                                              ),
                                                ),
                                                )
                                          ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:20,bottom: 10,top:10, right: 20),
                                          child: Text(
                                                min.toString(),
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                                )
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(left:20,bottom: 10,top:10, right: 20),
                                            child:ButtonTheme(
                                                  minWidth: 30.0,
                                                  height: 30.0,
                                                  child:  RaisedButton(
                                                    elevation: 5.0,
                                                    color : Colors.deepOrange,
                                                    onPressed: (){
                                                        setState(() {
                                                        if(min>0){
                                                          min--;
                                                        }else{
                                                          min = 59;
                                                        }
                                                      });
                                                    },
                                                    child:  Padding(
                                                                padding: const EdgeInsets.only(top:5, left: 5, right: 5, bottom: 5),
                                                                child: new Icon(
                                                                          Icons.arrow_drop_down,
                                                                          color: Colors.white,
                                                                          size: 20.0,
                                                                        ),
                                                              ),
                                                ),
                                                )
                                          ),
                                     ],
                                   ),
                                  
                                 ),
                                ],
                              ),
                          ],
                        ),
                       
                      ),
                  
                  ), 

                  Padding(
                     padding: const EdgeInsets.only(bottom: 5, top: 10, right: 10, left: 10),
                    child: Container(
                      height: 80,
                       decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.orangeAccent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange,
                              offset: Offset(1.0, 2.0), //(x,y)
                            ),
                          ],
                        ),
                       child:Column(children: <Widget>[

                          Padding(
                      padding: const EdgeInsets.only(bottom: 5, top: 10, right: 10, left: 10),
                    child:  Container(
                     height: 60,
                      width:350,
                        child: 
                        Row(
                          children: <Widget>[
                             Padding(
                              padding: const EdgeInsets.only(left:20,bottom: 10),
                              child: Text(
                                     "Todos",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                    )
                            ),
                            new Spacer(),
                             Padding(
                              padding: const EdgeInsets.only(left:20,bottom: 10, top: 10, right: 10),
                              child: Checkbox(
                                  value: todos,
                                  onChanged: _value8Changed,
                                  activeColor: Colors.deepOrange,
                              ),
                            ),
                          ],
                        ),
                      ),
                  
                  ), 

                       ],)
                  ),),

                         Padding(
                              padding: const EdgeInsets.only(left:20,bottom: 10, top: 10, right: 10),
                              child: RaisedButton (
                                  elevation:5.0,
                                  color : Colors.orangeAccent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.orangeAccent)
                                    ),
                                  onPressed: () {
                                      _addAlarm();
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


                ],
              ),
    );
    }else{
    return SingleChildScrollView(
          child: Column(
                children: <Widget>[


                  Padding(
                      padding: const EdgeInsets.only(bottom: 5, top: 10, right: 10, left: 10),
                    child:  Container(
                     height: 200,
                      width:350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.orangeAccent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange,
                              offset: Offset(1.0, 2.0), //(x,y)
                            ),
                          ],
                        ),
                        child: 
                        Column(
                          children: <Widget>[
                               Row(
                                children: <Widget>[
                                 Container(
                                   width: 160,
                                   height: 200,
                                   child:  Column(

                                     children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.only(left:20,bottom: 10,top:20, right: 20),
                                            child:ButtonTheme(
                                                  minWidth: 30.0,
                                                  height: 30.0,
                                                  child:  RaisedButton(
                                                    elevation: 5.0,
                                                    color : Colors.deepOrange,
                                                    onPressed: (){
                                                        setState(() {
                                                        if(hora<23){
                                                          hora++;
                                                        }else{
                                                          hora =0;
                                                        }
                                                      });
                                                    },
                                                    child:  Padding(
                                                                padding: const EdgeInsets.only(top:5, left: 5, right: 5, bottom: 5),
                                                                child: new Icon(
                                                                          Icons.arrow_drop_up,
                                                                          color: Colors.white,
                                                                          size: 20.0,
                                                                        ),
                                                              ),
                                                ),
                                                )
                                          ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:20,bottom: 10,top:10, right: 20),
                                          child: Text(
                                                hora.toString(),
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                                )
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(left:20,bottom: 10,top:10, right: 20),
                                            child:ButtonTheme(
                                                  minWidth: 30.0,
                                                  height: 30.0,
                                                  child:  RaisedButton(
                                                    elevation: 5.0,
                                                    color : Colors.deepOrange,
                                                    onPressed: (){
                                                      setState(() {
                                                        if(hora>0){
                                                          hora--;
                                                        }else{
                                                          hora = 23;
                                                        }
                                                      });
                                                    },
                                                    child:  Padding(
                                                                padding: const EdgeInsets.only(top:5, left: 5, right: 5, bottom: 5),
                                                                child: new Icon(
                                                                          Icons.arrow_drop_down,
                                                                          color: Colors.white,
                                                                          size: 20.0,
                                                                        ),
                                                              ),
                                                ),
                                                )
                                          ),
                                     ],
                                   ),
                                  
                                 ),
                                  Container(
                                   width: 20,
                                   height: 200,
                                   child:   Padding(
                                        padding: const EdgeInsets.only(left:2,top:60,bottom: 60),
                                        child:
                                        Column(children: <Widget>[
                                            new Spacer(),
                                               Text(
                                              ":",
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                                              ),
                                            new Spacer(),
                                        ],),
                                        
                                        
                                      ),
                                 ),
                                  Container(
                                   width: 160,
                                   height: 200,
                                   child:  Column(

                                     children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.only(left:20,bottom: 10,top:20, right: 20),
                                            child:ButtonTheme(
                                                  minWidth: 30.0,
                                                  height: 30.0,
                                                  child:  RaisedButton(
                                                    elevation: 5.0,
                                                    color : Colors.deepOrange,
                                                    onPressed: (){
                                                        setState(() {
                                                        if(min<59){
                                                          min++;
                                                        }else{
                                                          min = 0;
                                                        }
                                                      });
                                                    },
                                                    child:  Padding(
                                                                padding: const EdgeInsets.only(top:5, left: 5, right: 5, bottom: 5),
                                                                child: new Icon(
                                                                          Icons.arrow_drop_up,
                                                                          color: Colors.white,
                                                                          size: 20.0,
                                                                        ),
                                                              ),
                                                ),
                                                )
                                          ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:20,bottom: 10,top:10, right: 20),
                                          child: Text(
                                                min.toString(),
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                                )
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(left:20,bottom: 10,top:10, right: 20),
                                            child:ButtonTheme(
                                                  minWidth: 30.0,
                                                  height: 30.0,
                                                  child:  RaisedButton(
                                                    elevation: 5.0,
                                                    color : Colors.deepOrange,
                                                    onPressed: (){
                                                        setState(() {
                                                        if(min>0){
                                                          min--;
                                                        }else{
                                                          min = 59;
                                                        }
                                                      });
                                                    },
                                                    child:  Padding(
                                                                padding: const EdgeInsets.only(top:5, left: 5, right: 5, bottom: 5),
                                                                child: new Icon(
                                                                          Icons.arrow_drop_down,
                                                                          color: Colors.white,
                                                                          size: 20.0,
                                                                        ),
                                                              ),
                                                ),
                                                )
                                          ),
                                     ],
                                   ),
                                  
                                 ),
                                ],
                              ),
                          ],
                        ),
                       
                      ),
                  
                  ), 

                  Padding(
                     padding: const EdgeInsets.only(bottom: 5, top: 10, right: 10, left: 10),
                    child: Container(
                      height: 600,
                       decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.orangeAccent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange,
                              offset: Offset(1.0, 2.0), //(x,y)
                            ),
                          ],
                        ),
                       child:Column(children: <Widget>[

                          Padding(
                      padding: const EdgeInsets.only(bottom: 5, top: 10, right: 10, left: 10),
                    child:  Container(
                     height: 60,
                      width:350,
                      
                        child: 
                        Row(
                          children: <Widget>[
                             Padding(
                              padding: const EdgeInsets.only(left:20,bottom: 10),
                              child: Text(
                                     "Todos",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                    )
                            ),
                            new Spacer(),
                             Padding(
                              padding: const EdgeInsets.only(left:20,bottom: 10, top: 10, right: 10),
                              child: Checkbox(
                                  value: todos,
                                  onChanged: _value8Changed,
                                  activeColor: Colors.deepOrange,
                              ),
                            ),
                          ],
                        ),
                      ),
                  
                  ), 

                           Padding(
                      padding: const EdgeInsets.only(bottom: 5, top: 10, right: 10, left: 10),
                    child:  Container(
                     height: 60,
                      width:350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.deepOrangeAccent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange,
                              offset: Offset(1.0, 2.0), //(x,y)
                            ),
                          ],
                        ),
                        child: 
                        Row(
                          children: <Widget>[
                             Padding(
                              padding: const EdgeInsets.only(left:20,bottom: 10),
                              child: Text(
                                     "Segunda",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                    )
                            ),
                            new Spacer(),
                             Padding(
                              padding: const EdgeInsets.only(left:20,bottom: 10, top: 10, right: 10),
                              child: Checkbox(
                                  value: seg,
                                  onChanged: _value1Changed,
                                  activeColor: Colors.orangeAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                  
                  ), 


                    Padding(
                     padding: const EdgeInsets.only(bottom: 5, top: 5, right: 10, left: 10),
                    child:  Container(
                     height: 60,
                      width:350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.deepOrangeAccent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange,
                              offset: Offset(1.0, 2.0), //(x,y)
                            ),
                          ],
                        ),
                        child: 
                        Row(
                          children: <Widget>[
                             Padding(
                              padding: const EdgeInsets.only(left:20,bottom: 10),
                              child: Text(
                                     "Terça",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                    )
                            ),
                            new Spacer(),
                             Padding(
                              padding: const EdgeInsets.only(left:20,bottom: 10, top: 10, right: 10),
                              child: Checkbox(
                                  value: ter,
                                  onChanged: _value2Changed,
                                  activeColor:  Colors.orangeAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                  
                  ), 


                    Padding(
                      padding: const EdgeInsets.only(bottom: 5, top: 5, right: 10, left: 10),
                    child:  Container(
                     height: 60,
                      width:350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.deepOrangeAccent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange,
                              offset: Offset(1.0, 2.0), //(x,y)
                            ),
                          ],
                        ),
                        child: 
                        Row(
                          children: <Widget>[
                             Padding(
                              padding: const EdgeInsets.only(left:20,bottom: 10),
                              child: Text(
                                     "Quarta",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                    )
                            ),
                            new Spacer(),
                             Padding(
                              padding: const EdgeInsets.only(left:20,bottom: 10, top: 10, right: 10),
                              child: Checkbox(
                                  value: qua,
                                  onChanged: _value3Changed,
                                  activeColor:  Colors.orangeAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                  
                  ), 


                    Padding(
                     padding: const EdgeInsets.only(bottom: 5, top: 5, right: 10, left: 10),
                    child:  Container(
                     height: 60,
                      width:350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.deepOrangeAccent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange,
                              offset: Offset(1.0, 2.0), //(x,y)
                            ),
                          ],
                        ),
                        child: 
                        Row(
                          children: <Widget>[
                             Padding(
                              padding: const EdgeInsets.only(left:20,bottom: 10),
                              child: Text(
                                     "Quinta",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                    )
                            ),
                            new Spacer(),
                             Padding(
                              padding: const EdgeInsets.only(left:20,bottom: 10, top: 10, right: 10),
                              child: Checkbox(
                                  value: qui,
                                  onChanged: _value4Changed,
                                  activeColor:  Colors.orangeAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                  
                  ), 


                    Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 5, right: 10, left: 10),
                    child:  Container(
                     height: 60,
                      width:350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.deepOrangeAccent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange,
                              offset: Offset(1.0, 2.0), //(x,y)
                            ),
                          ],
                        ),
                        child: 
                        Row(
                          children: <Widget>[
                             Padding(
                              padding: const EdgeInsets.only(left:20,bottom: 10),
                              child: Text(
                                     "Sexta",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                    )
                            ),
                            new Spacer(),
                             Padding(
                              padding: const EdgeInsets.only(left:20,bottom: 10, top: 10, right: 10),
                              child: Checkbox(
                                  value: sex,
                                  onChanged: _value5Changed,
                                  activeColor:  Colors.orangeAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                  
                  ),  


                    Padding(
                     padding: const EdgeInsets.only(bottom: 5, top: 5, right: 10, left: 10),
                    child:  Container(
                     height: 60,
                      width:350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.deepOrangeAccent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange,
                              offset: Offset(1.0, 2.0), //(x,y)
                            ),
                          ],
                        ),
                        child: 
                        Row(
                          children: <Widget>[
                             Padding(
                              padding: const EdgeInsets.only(left:20,bottom: 10),
                              child: Text(
                                     "Sábado",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                    )
                            ),
                            new Spacer(),
                             Padding(
                              padding: const EdgeInsets.only(left:20,bottom: 10, top: 10, right: 10),
                              child: Checkbox(
                                  value: sab,
                                  onChanged: _value6Changed,
                                  activeColor:  Colors.orangeAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                  
                  ), 


                    Padding(
                   padding: const EdgeInsets.only(bottom: 10, top: 5, right: 10, left: 10),
                    child:  Container(
                     height: 60,
                      width:350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.deepOrangeAccent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange,
                              offset: Offset(1.0, 2.0), //(x,y)
                            ),
                          ],
                        ),
                        child: 
                        Row(
                          children: <Widget>[
                             Padding(
                              padding: const EdgeInsets.only(left:20,bottom: 10),
                              child: Text(
                                     "Domingo",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                                    )
                            ),
                            new Spacer(),
                             Padding(
                              padding: const EdgeInsets.only(left:20,bottom: 10, top: 10, right: 10),
                              child: Checkbox(
                                  value: dom,
                                  onChanged: _value7Changed,
                                  activeColor:  Colors.orangeAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                  
                  ), 

                       ],)
                  ),),

                         Padding(
                              padding: const EdgeInsets.only(left:20,bottom: 10, top: 10, right: 10),
                              child: RaisedButton (
                                  elevation:5.0,
                                  color : Colors.orangeAccent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.orangeAccent)
                                    ),
                                  onPressed: () {
                                      _addAlarm();
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


                ],
              ),
    );
}
  }
}

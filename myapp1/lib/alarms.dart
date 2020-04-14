import 'package:flutter/material.dart';
import 'package:myapp1/alarms/locationAlarm.dart';
import 'package:myapp1/medicationPage.dart';
import 'model/alarme.dart';
import 'addAlarm.dart';
import 'model/medToalarm.dart';
import 'model/med.dart';


class Alarms extends StatelessWidget {
  String lng;
  Alarms({this.lng});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(250, 245, 245, 245),
          appBar: new AppBar(
                 title: new Text((lng == "pt"? "Alarmes": "Alarms")),
                 backgroundColor: Colors.orangeAccent,),

      body: AlarmsSample(lng : lng),
    );
  }
}
 bool isSwitched = true;

class AlarmsSample extends StatefulWidget {
  String lng;
  AlarmsSample({this.lng});
  @override
  State<AlarmsSample> createState() => AlarmsSampleState(lng : lng);
}

class AlarmsSampleState extends State<AlarmsSample> {
  String lng;
  AlarmsSampleState({this.lng});

  bool loading = true;
  bool deleating = false;
  final dbHelper = DatabaseHelper1.instance;
  final dbHelper2 = DatabaseHelper3.instance;
  final dbHelper3 = DatabaseHelperMedtoAlarm.instance;
  List<AlarmClass> alarmList= [];
  List<Padding> printPad = [];
  List <MedicationList> med = [];


  //retorna todas as casas
   _query() async {
     alarmList.clear();
     print('query all rows:');
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) {
      setState(() {
        print(row['_id']);
        alarmList.add(
          AlarmClass(
              id: row['_id'],
              seg: row['seg'],
              ter: row ['ter'],
              qua: row['qua'],
              qui : row['quin'],
              sex : row ['sex'],
              sab : row ['sab'],
              dom : row ['dom'],
              active: row['active'],
              hora : row ['hora'],
              min : row['min']
          ),
        );
      });
      
    });
  }
  
  _removeMed(int i1) async{
    dbHelper.delete(i1).then((Null){
         dbHelper3.selectone(i1).then(
          (value){
                value.forEach((s){
                    dbHelper.delete(s['_id']);
                }
                  
                );
                initState();
          }
         );
    });
  }
 _getMedication (int i1) {
   List <Padding> mem = [];
      dbHelper3.selectone(i1).then(
          (value){
            print(value);
                if(value.length==0){
                     showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: new Text((lng == "pt" ?  "Sem medicamentos associados": "No associated medicantion")),
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
                  int size = value.length;
                      value.forEach((s){
                         dbHelper2.selectone(s['med']).then((n2){
                            n2.forEach((n3){
                              mem.add(
                                  Padding(
                                      padding: const EdgeInsets.only(right: 10, top: 10, bottom: 3, left: 10) ,
                                      child:  Text(
                                           n3['nome'],
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),
                                          textAlign: TextAlign.center,
                                      ),
                                    ),
                                );
                            });
                            size--;
                            if(size==0){
                               showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Column(
                                      children: mem,
                                    ),
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
                            
                         });
                      });
                         
                }
          }
      );

 }


  @override
    void initState() {
    _query().then((Null){
          List<Padding> pad = [];
          alarmList.forEach((f){
                        pad.add( Padding(
                             padding:  const EdgeInsets.only(top:10),
                            child:                         
                              Container(
                                  padding: const EdgeInsets.only(top:1),
                                  height: 240,
                                  width:350,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.white,
                                      boxShadow: [
                                       BoxShadow(
                                          color: Colors.black45,
                                          offset: Offset(2.0, 3.0), //(x,y)
                                        ),
                                      ],
                                    ),
                                  child:
                                  Column(children: <Widget>[
                                    Row(children: <Widget>[
                                         Container(
                                          width: 200,
                                          height: 100,
                                          child: Padding( padding: const EdgeInsets.only(top:26,right: 6, left: 10),
                                          child: Text(
                                            f.hora.toString() + ":" + f.min.toString(),
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50, color: Colors.black87),
                                              textAlign: TextAlign.left,
                                          ),),
                                        ),
                                        new Spacer(),
                                        Padding(
                                                  padding: const EdgeInsets.only(right: 20, top: 10, bottom: 3, left: 10) ,
                                                  child: SizedBox(
                                                  width: 60, 
                                                  height: 60,
                                                  child: FlatButton (
                                                    
                                                    shape:RoundedRectangleBorder(
                                                        borderRadius: new BorderRadius.circular(40.0),
                                                        side: BorderSide(color: Colors.black38),
                                                      ),
                                                    onPressed: (){
                                                       _removeMed(f.id);
                                                    },
                                                    color: Colors.white,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 3, top: 3, bottom: 3, left: 3) ,
                                                        child: Icon(Icons.close, color: Colors.black,size: 22.0,),
                                                       )
                                                      ],
                                                    ), 
                                                ),
                                                ),)
                                    ],),
                                   
                                  Row(
                                    children: <Widget>[
                                      Padding(padding: const EdgeInsets.all(5),
                                              child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(40.0),
                                                      color:  (f.dom == 1 ? Colors.orangeAccent : Color.fromRGBO(242, 242, 242, 1)),
                                                      boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black45,
                                                          offset: Offset(2.0, 3.0), //(x,y)
                                                        ),
                                                      ],
                                                    ),
                                                  child: Padding( padding: const EdgeInsets.all(10),
                                                  child: Text(
                                                     (lng == "pt" ?  "D": "S"),
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                                                      textAlign: TextAlign.center,
                                                  ),),
                                                ),
                                        ),
                                        Padding(padding: const EdgeInsets.all(5),
                                              child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(40.0),
                                                      color: (f.seg == 1 ? Colors.orangeAccent : Color.fromRGBO(242, 242, 242, 1)),
                                                      boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black45,
                                                          offset: Offset(2.0, 3.0), //(x,y)
                                                        ),
                                                      ],
                                                    ),
                                                  child: Padding( padding: const EdgeInsets.all(10),
                                                  child: Text(
                                                      (lng == "pt" ?  "S": "M"),
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                                                      textAlign: TextAlign.center,
                                                  ),),
                                                ),
                                        ),
                                        Padding(padding: const EdgeInsets.all(5),
                                              child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(40.0),
                                                      color: (f.ter == 1 ? Colors.orangeAccent : Color.fromRGBO(242, 242, 242, 1)),
                                                      boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black45,
                                                          offset: Offset(2.0, 3.0), //(x,y)
                                                        ),
                                                      ],
                                                    ),
                                                  child: Padding( padding: const EdgeInsets.all(10),
                                                  child: Text(
                                                      "T",
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                                                      textAlign: TextAlign.center,
                                                  ),),
                                                ),
                                        ),
                                        Padding(padding: const EdgeInsets.all(5),
                                              child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(40.0),
                                                      color: (f.qua == 1 ? Colors.orangeAccent : Color.fromRGBO(242, 242, 242, 1)),
                                                      boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black45,
                                                          offset: Offset(2.0, 3.0), //(x,y)
                                                        ),
                                                      ],
                                                    ),
                                                  child: Padding( padding: const EdgeInsets.all(10),
                                                  child: Text(
                                                      (lng == "pt" ?  "Q": "W"),
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                                                      textAlign: TextAlign.center,
                                                  ),),
                                                ),
                                        ),
                                        Padding(padding: const EdgeInsets.all(5),
                                              child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(40.0),
                                                      color: (f.qui == 1 ? Colors.orangeAccent : Color.fromRGBO(242, 242, 242, 1)),
                                                      boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black45,
                                                          offset: Offset(2.0, 3.0), //(x,y)
                                                        ),
                                                      ],
                                                    ),
                                                  child: Padding( padding: const EdgeInsets.all(10),
                                                  child: Text(
                                                      (lng == "pt" ?  "Q": "T"),
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                                                      textAlign: TextAlign.center,
                                                  ),),
                                                ),
                                        ),
                                        Padding(padding: const EdgeInsets.all(5),
                                              child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(40.0),
                                                      color: (f.sex == 1 ? Colors.orangeAccent : Color.fromRGBO(242, 242, 242, 1)),
                                                      boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black45,
                                                          offset: Offset(2.0, 3.0), //(x,y)
                                                        ),
                                                      ],
                                                    ),
                                                  child: Padding( padding: const EdgeInsets.all(10),
                                                  child: Text(
                                                      (lng == "pt" ?  "S": "F"),
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                                                      textAlign: TextAlign.center,
                                                  ),),
                                                ),
                                        ),
                                        Padding(padding: const EdgeInsets.all(5),
                                              child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(40.0),
                                                      color:(f.sab == 1 ? Colors.orangeAccent :Color.fromRGBO(242, 242, 242, 1)),
                                                      boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black45,
                                                          offset: Offset(2.0, 3.0), //(x,y)
                                                        ),
                                                      ],
                                                    ),
                                                  child: Padding( padding: const EdgeInsets.all(10),
                                                  child: Text(
                                                      "S",
                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                                                      textAlign: TextAlign.center,
                                                  ),),
                                                ),
                                        )
                                        
                                    ],
                                  ),
                                    Padding(
                                                  padding: const EdgeInsets.only(right: 20, top: 10, bottom: 3, left: 10) ,
                                                  child: SizedBox(
                                                  width: 70, 
                                                  height: 70,
                                                  child: FlatButton (
                                                    
                                                    shape:RoundedRectangleBorder(
                                                        borderRadius: new BorderRadius.circular(40.0),
                                                        side: BorderSide(color: Colors.black38),
                                                      ),
                                                    onPressed: (){
                                                       _getMedication(f.id);
                                                    },
                                                    color: Colors.orangeAccent,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 0, top: 0, bottom: 0, left: 0) ,
                                                        child: Image.network(
                                                        'https://cdn3.iconfinder.com/data/icons/health/100/pill_capsule-512.png',
                                                            width: 35,
                                                            height: 35,
                                                            color: Colors.white,
                                                        ),
                                                       )
                                                      ],
                                                    ), 
                                                ),
                                                ),)
                                 ]
                                 )
                                 ))
                                  );
                             setState(() {
                              printPad=pad;
                            });
                    });
                  });

}
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
                 Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AlarmsAdd(lng : lng )),
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
          body: new ListView(
                padding: const EdgeInsets.all(8),
                children: printPad,
              ),
    );

  }
}


class AlarmClass{

  final int id;
  final int hora;
  final int min;
  final int seg;
  final int ter;
  final int qua;
  final int qui;
  final int sex;
  final int dom;
  final int sab;
  final int active;

  AlarmClass({this.id, this.hora, this.min, this.seg, this.ter,this.qua, this.qui, this.sex, this.sab, this.dom, this.active});


}

class MedicationList {
  final List <Padding> listp;
  final int id;

  MedicationList ({this.id, this.listp});
}
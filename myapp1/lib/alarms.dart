import 'package:flutter/material.dart';
import 'model/alarme.dart';
import 'addAlarm.dart';

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
  bool loading = true;
  bool deleating = false;
  final dbHelper = DatabaseHelper1.instance;
  List<AlarmClass> alarmList= [];
  List<Padding> printPad = [];

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



  @override
    void initState() {
    _query().then((Null){
          List<Padding> pad = [];
          int size = alarmList.length;
          alarmList.forEach((f){
            size --;
             pad.add(    Padding(
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
                                          f.hora.toString() + ":" + f.min.toString(),
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black54),
                                        
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child:Text(
                                                ( (f.seg==1 && f.ter==1 && f.qua==1 && f.qui==1 && f.sex==1 && f.sab==1 && f.dom==1) ? "todos os dias" 
                                                :
                                                (f.seg == 1 ? "seg," : "") + (f.ter==1 ? "ter," : "") +  (f.qua==1 ? "qua," : "")+
                                                (f.qui == 1 ? "qui," : "") + (f.sex==1 ? "sex," : "") +  (f.sab==1 ? "sab," : "")+
                                                  (f.dom == 1 ? "dom," : "") 
                                                ),
                                                
                                              )
                                        ),
                                        
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
            ));
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
                        MaterialPageRoute(builder: (context) => AlarmsAdd()),
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
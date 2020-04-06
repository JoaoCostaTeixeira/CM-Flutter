import 'dart:async';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'model/house.dart';

void main() => runApp(Houses());




class Houses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color.fromARGB(250, 245, 245, 245),
          appBar: new AppBar(
                 title: new Text("Farmácias"),
                 backgroundColor: Colors.blueGrey,),

      body: HousesSample(),
    );
  }
}
 bool isSwitched = true;

class HousesSample extends StatefulWidget {
  @override
  State<HousesSample> createState() => HousesSampleState();
}

class HousesSampleState extends State<HousesSample> {
  
  bool loading = true;
   final dbHelper = DatabaseHelper.instance;

   void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : 'Bob',
      DatabaseHelper.columnLat  : 23,
      DatabaseHelper.columnLong  : 23,
      DatabaseHelper.columnActive : 1,

    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void _query() async {
     print('query all rows:');
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }



    @override
    void initState() {
      _query();
     }

  @override
  Widget build(BuildContext context) {
    if(loading){
      return Scaffold(
                  backgroundColor: Color.fromRGBO(229,239,241, 100),
                  body: Center(
                    child: Image.asset(
                    'assets/images/loading.gif',
                    height: 205.0,
                    width: 205.0,
                  ),
                ),
                    );
    }else{
         return Scaffold(
                  backgroundColor: Color.fromRGBO(229,239,241, 100),
                  body: Center(
                    child: Image.asset(
                    'assets/images/loading.gif',
                    height: 205.0,
                    width: 205.0,
                  ),
                ),
                    );
    }
    
  }
}






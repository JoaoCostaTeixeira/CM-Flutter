
/*import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class add_reqP extends StatefulWidget{
  @override
  add_reqPState createState()=> add_reqPState();
}

class add_reqPState extends State<add_reqP> {
  final List<String> _dropdownValues = [
    "4.1.2",
    "4.1.69",
    "Anf. V"
  ]; //The list of values we want on the dropdown

  final List<String> _dropdownItem = [
    "Cadeira",
    "Mesa",
    "Teclado",
    "Rato",
    "Ecrã",
    "Projetor",
    "Outro"
  ]; //T
  var _SelectdType = "Espaço";
  var _SelectdType2 = "Item";
  TextEditingController _notas = TextEditingController();
  TextEditingController _quantidade = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var titles = new List();

    double _vartest = double.parse(titles.length.toString());
    var slash = '/';

    return new Scaffold(
      appBar: AppBar
        (
        leading: IconButton(
          icon: new Icon(Icons.arrow_back,
              color: Colors.black,
              size: 30.0),
          onPressed: () => {Navigator.of(context).pushNamed('/professor/requerimentos')}, //GO BACK TO LAST PAGE
        ),
        title: Row(children: <Widget>[
          Text(
            "Requisição de Material",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ],
        ),
        elevation: 5.0,
        //centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(padding: EdgeInsets.fromLTRB(0.0, 5.0, 15.0, 15.0),
            child:  IconButton(
              icon: Icon(Icons.work,
                color: Colors.blueGrey,
                size: 40.0,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/professor/main_menu');
              },
            ),
          ),
        ],
      ),
      body:

      Center(
        child:
        StaggeredGridView.count(
          crossAxisCount: 6,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 0.0,
          padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 30.0),
          staggeredTiles: [
            StaggeredTile.extent(6,70),
            StaggeredTile.extent(6,25),
            StaggeredTile.extent(6,70),
            StaggeredTile.extent(6,25),
            StaggeredTile.extent(6,70),
            StaggeredTile.extent(6,25),
            StaggeredTile.extent(6,70),
            StaggeredTile.extent(6,60),
            StaggeredTile.extent(6,45),
            StaggeredTile.extent(3,45),

          ],
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new DropdownButton(
                    items: _dropdownValues
                        .map((value) => DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    ))
                        .toList(),
                    onChanged: (String value) {
                      _SelectdType= value;
                      setState(() {});
                    },
                    isExpanded: false,
                    hint: Text(_SelectdType),
                  ),)
              ],
            ),
            Container(
              height: 10.0,
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                  child: new DropdownButton(
                    items: _dropdownItem
                        .map((value) => DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    ))
                        .toList(),
                    onChanged: (String value) {
                      _SelectdType2= value;
                      setState(() {});
                    },
                    isExpanded: false,
                    hint: Text(_SelectdType2),
                  ),)
              ],
            ),
            Container(
              height: 10.0,
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                    child: new TextField(
                      controller: _quantidade,
                      autofocus: false,
                      decoration: new InputDecoration(
                          labelText: 'Quantidade', hintText: 'Quantidade de items, eg. 1,2,3'),
                    ))
              ],
            ),
            Container(
              height: 10.0,
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                    child: new TextField(
                      controller: _notas,
                      autofocus: false,
                      decoration: new InputDecoration(
                          labelText: 'Notas', hintText: 'eg. Se disse outro referenciar o item necessário...'),
                    ))
              ],
            ),
            Container(
              height: 10.0,
            ),


            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new FlatButton(
                  child: new Text('CANCELAR', style: TextStyle(color: Colors.red),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text('ADICIONAR', style: TextStyle(color: Colors.green),),
                  onPressed: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true, onConfirm: (date) {
                          print('confirm $date');
                          Navigator.of(context).pop();
                          confirmReq();
                          confirmReq();
                          //globals.requerimentos.add([date.day.toString() + slash + date.month.toString() + slash + date.year.toString(), 'Manuel', _SelectdType.toString(), _SelectdType2.toString()]);
                          //print(globals.requerimentos);
                        }, currentTime: DateTime.now(), locale: LocaleType.pt);

                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();
  void confirmReq() {
    Alert(
      context: context,
      type: AlertType.info,
      title: "Requerimento feito",
      desc: "Requerimento feito com sucesso",
      buttons: [
        DialogButton(
          child: Text(
            "CONFIRMAR",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => {Navigator.of(context).pushNamed('/professor/requerimentos')},
          color: Colors.green,
        ),

      ],
    ).show();
  }
  void _showDialogRemove() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text('Remover item de Stock'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Expanded(
                      child: new TextField(
                        controller: _textFieldController,
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Referência', hintText: 'eg. 1234567890'),
                      ))
                ],
              ),
              Container(
                height: 10.0,
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                      child: new TextField(
                        autofocus: true,
                        decoration: new InputDecoration(
                            labelText: 'Quantidade', hintText: 'eg. 1'),
                      ))
                ],
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              children: <Widget>[
                new FlatButton(
                  child: new Text('REMOVER', style: TextStyle(color: Colors.red),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text('CANCELAR', style: TextStyle(color: Colors.green),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )



          ],
        );
      },
    );
  }
  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        child: InkWell
          (
          // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null ? () => onTap() : () { print('Not set yet'); },
            child: child
        )
    );
  }

  Padding _tileFormat(String title, String quant, String desc) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [

            Container(
              height: 50.0,
              width: 127.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[ Material (
                  child: Text(title, style: TextStyle(color: Colors.black, fontSize: 18.0)
                  ),
                ),
                ],
              ),

            ),
            Container(
              height: 50.0,
              width: 128.0,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[ Material (
                  child: Text(quant, style: TextStyle(color: Colors.black, fontSize: 18.0)
                  ),
                ),
                ],
              ),
            ),
            Container(
              height: 50.0,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[ Material (
                  child: Text(desc, style: TextStyle(color: Colors.black, fontSize: 18.0)
                  ),
                ),
                ],
              ),
            )
          ]
      ),
    );
  }
}*/
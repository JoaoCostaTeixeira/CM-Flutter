import 'package:flutter/material.dart';
import 'package:myapp1/add_medication.dart';
import 'package:myapp1/medication_list/medication_list.dart';
import 'package:myapp1/medication_list/modal/medication.dart';

class MedicationPage extends StatelessWidget {
  _buildMedicationList() {
    return <MedicationModal>[
       MedicationModal(
          name: 'Romain Hoogmoed', date: new DateTime(2020,10,10,10,10,10,10), timeOfDay: TimeOfDay.now()),
      MedicationModal(
          name: 'jjj Hoogmoed', date: new DateTime(2020,10,10,10,10,10,10), timeOfDay: TimeOfDay.now()),
      MedicationModal(
          name: 'Romaaaain Hoogmoed', date: new DateTime(2020,10,10,10,10,10,10), timeOfDay: TimeOfDay.now()),
      MedicationModal(
          name: 'aaa Hoogmoed', date: new DateTime(2020,10,10,10,10,10,10), timeOfDay: TimeOfDay.now()),
      MedicationModal(
          name: 'vvv Hoogmoed', date: new DateTime(2020,10,10,10,10,10,10), timeOfDay: TimeOfDay.now()),
      MedicationModal(
          name: 'Romawqeqin Hoogmoed', date: new DateTime(2020,10,10,10,10,10,10), timeOfDay: TimeOfDay.now()),
      MedicationModal(
          name: 'Romain qweq', date: new DateTime(2020,10,10,10,10,10,10), timeOfDay: TimeOfDay.now()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: MedicationList(_buildMedicationList()),
      floatingActionButton:
      FloatingActionButton.extended(
        heroTag: "btn1",
        icon: Icon(Icons.add,
          color: Colors.white,),
        backgroundColor: Colors.blueGrey,
        label: Text("Adicionar", style: TextStyle(
            color: Colors.white)),
        onPressed: () {Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => add_reqP()),
        );},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
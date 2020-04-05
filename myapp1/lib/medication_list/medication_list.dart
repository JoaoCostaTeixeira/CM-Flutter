import 'package:flutter/material.dart';
import 'package:myapp1/medication_list/medication_list_item.dart';
import 'package:myapp1/medication_list/modal/medication.dart';

class MedicationList extends StatelessWidget {
  final List<MedicationModal> _medicationModal;

  MedicationList(this._medicationModal);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      children: _buildMedicationList(),
    );
  }

  List<MedicationListItem> _buildMedicationList() {
    return _medicationModal
        .map((medication) => MedicationListItem(medication))
        .toList();
  }
}
import 'package:flutter/material.dart';
import 'package:myapp1/medication_list/modal/medication.dart';

class MedicationListItem extends StatelessWidget {
  final MedicationModal _medicationModal;

  MedicationListItem(this._medicationModal);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(child: Text(_medicationModal.name[0])),
        title: Text(_medicationModal.name),
        subtitle: Text(_medicationModal.date.toIso8601String()));
  }
}
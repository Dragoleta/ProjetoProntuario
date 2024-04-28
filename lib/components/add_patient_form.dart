import 'package:flutter/material.dart';
import 'package:prontuario_flutter/components/date_form_field.dart';
import 'package:prontuario_flutter/components/text_formField.dart';
import 'package:prontuario_flutter/config/langs/ptbr.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';

class AddPatientForm extends StatefulWidget {
  final GlobalKey<FormState> formkey;
  final ValueChanged<Patient> onChanged;
  final Patient patientModel;

  const AddPatientForm(
      {super.key,
      required this.formkey,
      required this.onChanged,
      required this.patientModel});

  @override
  State<AddPatientForm> createState() => _AddPatientFormState();
}

class _AddPatientFormState extends State<AddPatientForm> {
  // Focus nodes
  final _nameFocusNode = FocusNode();
  final _sexFocusNode = FocusNode();
  final _diagnoseFocusNode = FocusNode();
  final _motherNameFocusNode = FocusNode();
  final _fatherNameFocusNode = FocusNode();
  final _birthDateFocusNode = FocusNode();

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _sexFocusNode.dispose();
    _diagnoseFocusNode.dispose();
    _motherNameFocusNode.dispose();
    _fatherNameFocusNode.dispose();
    _birthDateFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formkey,
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyTextFormField(
                  focusNode: _nameFocusNode,
                  nextFocusNode: _sexFocusNode,
                  onChanged: (value) => widget
                      .onChanged(widget.patientModel.copyWith(name: value)),
                  currentValue: widget.patientModel.name,
                  validator: (value) =>
                      widget.patientModel.isEmptyValidator(value),
                  hintText: PATIENT_NAME,
                  labelText: PATIENT_NAME,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextFormField(
                  focusNode: _sexFocusNode,
                  nextFocusNode: _diagnoseFocusNode,
                  onChanged: (value) => widget
                      .onChanged(widget.patientModel.copyWith(sex: value)),
                  currentValue: widget.patientModel.sex,
                  validator: (value) =>
                      widget.patientModel.isEmptyValidator(value),
                  hintText: PATIENT_SEX,
                  labelText: PATIENT_SEX,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextFormField(
                  focusNode: _diagnoseFocusNode,
                  nextFocusNode: null,
                  onChanged: (value) => widget
                      .onChanged(widget.patientModel.copyWith(diagnose: value)),
                  currentValue: widget.patientModel.diagnose,
                  validator: (value) =>
                      widget.patientModel.isEmptyValidator(value),
                  hintText: DIAGNOSE,
                  labelText: DIAGNOSE,
                ),
                const SizedBox(
                  height: 20,
                ),
                DateFormField(
                  labelText: BIRTHDATE,
                  hintText: BIRTHDATE,
                  onChanged: (value) {
                    widget.onChanged(
                        widget.patientModel.copyWith(birthdate: value));
                  },
                  currentValue: widget.patientModel.birthdate,
                  validator: (value) =>
                      widget.patientModel.isEmptyValidator(value),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextFormField(
                  focusNode: _motherNameFocusNode,
                  nextFocusNode: _fatherNameFocusNode,
                  onChanged: (value) => widget.onChanged(
                      widget.patientModel.copyWith(motherName: value)),
                  currentValue: widget.patientModel.motherName,
                  validator: (value) =>
                      widget.patientModel.isEmptyValidator(value),
                  hintText: MOTHER_NAME,
                  labelText: MOTHER_NAME,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextFormField(
                  focusNode: _fatherNameFocusNode,
                  nextFocusNode: null,
                  onChanged: (value) => widget.onChanged(
                      widget.patientModel.copyWith(fatherName: value)),
                  currentValue: widget.patientModel.fatherName,
                  validator: (value) =>
                      widget.patientModel.isEmptyValidator(value),
                  hintText: FATHER_NAME,
                  labelText: FATHER_NAME,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}

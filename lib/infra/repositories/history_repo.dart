import 'package:prontuario_flutter/infra/database/connect.dart';
import 'package:prontuario_flutter/infra/models/history.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';

class HistoryRepo {
  Future<int> addHistory(PatientHistory history) async {
    try {
      final db = await Connection().getDB();
      return await db.insert('history', history.toJSON());
    } catch (e) {
      print('Error $e');
      return 2;
    }
  }

  Future<List<PatientHistory>?> getHistory() async {
    final db = await Connection().getDB();

    final List<Map<String, dynamic>> maps = await db.query('history');
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => PatientHistory.fromJson(maps[index]));
  }

  Future<List<PatientHistory>?> getHistoryFromPatient(String patientId) async {
    if ("" == patientId) {
      return null;
    }
    final db = await Connection().getDB();

    String query = 'SELECT * FROM history WHERE patient_id=$patientId';

    final List<Map<String, dynamic>> maps = await db.rawQuery(query);

    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => PatientHistory.fromJson(maps[index]));
  }

  Future<int> updateHistory(PatientHistory history) async {
    try {
      final db = await Connection().getDB();
      return await db.update(
          'history',
          where: 'patient_id = ${history.patientId} and id=${history.id}',
          history.toJSON());
    } catch (e) {
      print('Error $e');
      return 2;
    }
  }

  Future<int> deleteAppointmentFromDb(PatientHistory history) async {
    try {
      final db = await Connection().getDB();
      return await db.delete('history',
          where: 'id=${history.id} AND patient_id=${history.patientId}');
    } catch (e) {
      print('Errr $e');
    }
    return 0;
  }

  Future<int> deleteAllUsersAppointments(Patient patient) async {
    try {
      final db = await Connection().getDB();
      return await db.delete('history', where: 'patient_id=${patient.id}');
    } catch (e) {
      print('Errr $e');
    }
    return 0;
  }
}

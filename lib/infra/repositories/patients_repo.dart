import 'package:prontuario_flutter/infra/database/connect.dart';
import 'package:prontuario_flutter/infra/models/patient.dart';

class PatientsRepo {
  Future<int> addPatient(Patient patient) async {
    try {
      final db = await Connection().getDB();
      return await db.insert('patients', patient.toJSON());
    } catch (e) {
      print('Error $e');
      return 2;
    }
  }

  Future<int> addPatientfromJSon(patient) async {
    try {
      final db = await Connection().getDB();
      return await db.insert('patients', patient);
    } catch (e) {
      print('Error $e');
      return 2;
    }
  }

  Future<List<Patient>?> getAllPatients() async {
    final db = await Connection().getDB();

    final List<Map<String, dynamic>> maps = await db.query('patients');
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Patient.fromJson(maps[index]));
  }

  Future<List<Patient>?> getAllPatientsFromWorkplace(int? workplaceId) async {
    final db = await Connection().getDB();

    String query = 'SELECT * FROM patients WHERE workplace_id=$workplaceId';

    final List<Map<String, dynamic>> maps = await db.rawQuery(query);
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (index) => Patient.fromJson(maps[index]));
  }

  Future<int> deletePatientFromDb(Patient patient) async {
    try {
      final db = await Connection().getDB();
      return await db.delete('patients', where: 'id=${patient.id}');
    } catch (e) {
      print('Errr $e');
    }
    return 0;
  }
}

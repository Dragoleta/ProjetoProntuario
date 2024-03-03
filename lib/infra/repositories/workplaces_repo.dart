import 'package:prontuario_flutter/infra/database/connect.dart';
import 'package:prontuario_flutter/infra/models/workplace.dart';

class WorkplaceRepo {
  Future<int> addWorkplace(Workplace workplace) async {
    print('banana repo');
    try {
      final db = await Connection().getDB();
      return await db.insert('workplaces', workplace.toJSON());
    } catch (e) {
      print('Error $e');
    }
    return 0;
  }

  Future<int> deleteWorkplaceFromDb(Workplace workplace) async {
    try {
      final db = await Connection().getDB();
      return await db.delete('workplaces',
          where:
              'professinal_id=${workplace.professinalID} AND id=${workplace.id}');
    } catch (e) {
      print('Errr $e');
    }
    return 0;
  }

  Future<List<Workplace>?> getAllWorkplaces() async {
    final db = await Connection().getDB();

    final List<Map<String, dynamic>> maps = await db.query("workplaces");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => Workplace.fromJson(maps[index]));
  }
}

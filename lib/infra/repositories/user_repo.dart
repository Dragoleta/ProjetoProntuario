import 'package:prontuario_flutter/infra/database/connect.dart';
import 'package:prontuario_flutter/infra/models/user.dart';

class UserRepo {
  Future<Object> addUser(User user) async {
    try {
      final db = await Connection().getDB();

      return await db.insert('user', user.toJSON());
    } catch (e) {
      print('Error banana ADDUSER $e');
      return '';
    }
  }

  Future<User?> getUserFromLocalDB() async {
    try {
      final db = await Connection().getDB();

      final List<Map<String, dynamic>> maps = await db.query('user', limit: 1);
      if (maps.isEmpty) {
        return null;
      }

      User user = User.fromJson(maps[0]);

      return user;
    } catch (e) {
      print('Error banana userdb $e');
      return null;
    }
  }
}

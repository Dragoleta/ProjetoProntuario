import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:prontuario_flutter/infra/models/workplace.dart';

Future<List<Workplace>?>? getAllWorkplaces(authToken) async {
  try {
    Uri url =
        Uri.parse('${dotenv.env['API_URL']}/workplace/get_all_workplaces');

    http.Response res = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer ${authToken[0]}"
      },
    );

    if (res.statusCode != 200) {
      print('Failed to retrieve the http package! ${res.body}');
      return null;
    }

    final String responseBody = utf8.decode(res.bodyBytes);
    final List<dynamic> parsed = jsonDecode(responseBody);

    List<Workplace> yourModels =
        parsed.map((json) => Workplace.fromJson(json)).toList();

    return yourModels;
  } catch (e) {
    print('Banana Workplace $e');
    return null;
  }
}

Future<bool> createWorkplace(Workplace place, authToken) async {
  try {
    Uri url = Uri.parse('${dotenv.env['API_URL']}/workplace/add_workplace');

    var request = jsonEncode(<String, dynamic>{
      "name": place.name,
    });

    http.Response res = await http.post(
      url,
      headers: <String, String>{
        "Authorization": "Bearer ${authToken[0]}",
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: request,
    );

    if (res.statusCode != 200) {
      print('banana Failed to retrieve the http package! ${res.body}');
      return false;
    }
    return true;
  } catch (e) {
    print('Banana $e');
    return false;
  }
}

Future<bool?> deleteWorkplace(authToken, workplaceId) async {
  try {
    Uri url = Uri.parse(
        '${dotenv.env['API_URL']}/workplace/delete_workplace?workplace_id=$workplaceId');

    http.Response res = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer ${authToken[0]}"
      },
    );

    if (res.statusCode != 200) {
      print('Failed to retrieve the http package! ${res.body}');
      return false;
    }

    return true;
  } catch (e) {
    return false;
  }
}

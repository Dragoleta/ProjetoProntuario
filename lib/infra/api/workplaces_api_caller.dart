import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:prontuario_flutter/infra/models/workplace.dart';

Future<List<Workplace>?>? getAllWorkplaces(authToken) async {
  try {
    Uri url =
        Uri.parse('${dotenv.env['API_URL']}/workplace/get_all_workplaces');

    http.Response res = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            "access_token": authToken[0],
            "token_type": authToken[1],
          },
        ));

    if (res.statusCode != 200) {
      print('Failed to retrieve the http package! ${res.body}');
      return null;
    }
    // Decodes and maps before returning the response
    final List<dynamic> parsed = jsonDecode(res.body);
    List<Workplace> yourModels =
        parsed.map((json) => Workplace.fromJson(json)).toList();

    return yourModels;
  } catch (e) {
    print('Banana aq $e');
    return null;
  }
}

Future<bool> createWorkplace(Workplace place, authToken) async {
  try {
    print('Banana calling create place');

    Uri url = Uri.parse('${dotenv.env['API_URL']}/workplace/add_workplace');

    String request = jsonEncode(<String, dynamic>{
      "workplace": {
        "id": place.id,
        "name": place.name,
        "professional_id": place.professional_Id,
        if (place.createdAt != null) "createdAt": place.createdAt,
        if (place.deleted != null) "deleted": place.deleted
      },
      "authToken": {
        "access_token": authToken[0],
        "token_type": authToken[1],
      }
    });

    print('banana $request');
    http.Response res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: request,
    );
    print('banana ${res.body}');

    if (res.statusCode != 200) {
      print('banana Failed to retrieve the http package!');
      return false;
    }
    return true;
  } catch (e) {
    print('Banana $e');
    return false;
  }
}

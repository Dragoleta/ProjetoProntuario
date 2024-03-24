import 'package:flutter/material.dart';
import 'package:prontuario_flutter/infra/api/workplaces_api_caller.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/infra/models/workplace.dart';

// ignore: must_be_immutable
class WorkplaceCard extends StatelessWidget {
  final Workplace place;
  final LocalStorage storage;
  const WorkplaceCard({super.key, required this.place, required this.storage});
  // ignore: empty_constructor_bodies
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              // Change this to go to the patients from this workplace and set lcoal storage to the place
              onTap: () {
                storage.setCurrentWorkplace(place);
                Navigator.of(context).pushNamed('/patients');
              },
              child: Text(
                place.name,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[900],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () async {
                var authToken = storage.getActiveAuthToken();
                if (authToken == null) {
                  return;
                }
                bool? response = await deleteWorkplace(authToken, place.id);
                if (response == true) {
                  Navigator.of(context).popAndPushNamed('/workplaces');
                }
              },
              tooltip: "Delete this workplace",
            )
          ],
        ),
      ),
    );
  }
}

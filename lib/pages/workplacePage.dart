import "package:flutter/material.dart";
import "package:prontuario_flutter/infra/localstorage/local_storage.dart";
import "package:prontuario_flutter/infra/models/workplace.dart";
import "package:prontuario_flutter/infra/repositories/workplaces_repo.dart";
import "package:prontuario_flutter/stuff/appbar.dart";
import "package:prontuario_flutter/stuff/workplace_card.dart";

class WorkPlacePage extends StatefulWidget {
  final LocalStorage localStorage;
  const WorkPlacePage({
    super.key,
    required this.localStorage,
  });

  @override
  State<WorkPlacePage> createState() => _WorkPlacePageState();
}

bool __addPressed = false;

class _WorkPlacePageState extends State<WorkPlacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(context, actionButtonFuntion: () {
          __addPressed = true;
          setState(() {});
        }, appbarTitle: 'Workplaces', iconType: 0),
        backgroundColor: Colors.grey,
        body: Column(
          children: [
            Builder(builder: (context) {
              if (__addPressed == true) {
                return addPlaceCard(localStorage: widget.localStorage);
              }
              return const SizedBox();
            }),
            Expanded(
              child: workplacesCardsBuilder(widget.localStorage),
            ),
          ],
        ));
  }
}

FutureBuilder<List<Workplace>?> workplacesCardsBuilder(
    LocalStorage localStorage) {
  return FutureBuilder<List<Workplace>?>(
    future: WorkplaceRepo().getAllWorkplaces(),
    builder: (context, AsyncSnapshot<List<Workplace>?> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.hasData) {
        if (snapshot.data == null) {
          return const Text('No workplaces');
        }

        return ListView.builder(
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) {
            return WorkplaceCard(
              storage: localStorage,
              place: snapshot.data![index],
              delete: () {
                // TODO: Add func to remove from txt and json
                WorkplaceRepo().deleteWorkplaceFromDb(snapshot.data![index]);
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/workplaces');
              },
            );
          },
        );
      } else {
        return const Text('Nothing here ');
      }
    },
  );
}

// ignore: camel_case_types
class addPlaceCard extends StatelessWidget {
  final LocalStorage localStorage;

  const addPlaceCard({super.key, required this.localStorage});

  @override
  Widget build(BuildContext context) {
    int professinalId = localStorage.getCurrentProfessional();
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: TextField(
        onSubmitted: (e) {
          Workplace newPlace = Workplace(name: e, professinalID: professinalId);
          WorkplaceRepo().addWorkplace(newPlace);
          __addPressed = false;

          Navigator.of(context).pop();
          Navigator.of(context).pushNamed('/workplaces');
        },
        obscureText: false,
        style: TextStyle(fontSize: 18, color: Colors.grey[900]),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(10.0)),
          labelText: 'Place',
        ),
      ),
    );
  }
}

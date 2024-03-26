import "package:flutter/material.dart";
import "package:prontuario_flutter/infra/api/workplaces_api_caller.dart";
import "package:prontuario_flutter/infra/localstorage/local_storage.dart";
import "package:prontuario_flutter/infra/models/workplace.dart";
import "package:prontuario_flutter/widgets/appbar.dart";
import "package:prontuario_flutter/widgets/workplace_card.dart";

class WorkplacePage extends StatefulWidget {
  final LocalStorage localStorage;
  const WorkplacePage({
    super.key,
    required this.localStorage,
  });

  @override
  State<WorkplacePage> createState() => _WorkplacePageState();
}

bool __addPressed = false;

class _WorkplacePageState extends State<WorkplacePage> {
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
                return AddPlaceCard(localStorage: widget.localStorage);
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
  List<String>? token = localStorage.getActiveAuthToken();

  return FutureBuilder<List<Workplace>?>(
    future: getAllWorkplaces(token),
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
            );
          },
        );
      } else {
        return const Text('Nothing here ');
      }
    },
  );
}

class AddPlaceCard extends StatelessWidget {
  final LocalStorage localStorage;

  const AddPlaceCard({super.key, required this.localStorage});

  @override
  Widget build(BuildContext context) {
    String? professionalId = localStorage.getCurrentProfessionalId();
    List<String>? authToken = localStorage.getActiveAuthToken();
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: TextField(
        onSubmitted: (e) async {
          Workplace newPlace = Workplace(
            name: e,
            professional_Id: professionalId!,
          );
          bool res = await createWorkplace(newPlace, authToken);
          if (res == true) {
            __addPressed = false;

            Navigator.of(context).popAndPushNamed('/workplaces');
          }
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

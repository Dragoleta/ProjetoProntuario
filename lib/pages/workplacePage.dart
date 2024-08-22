import "package:flutter/material.dart";
import "package:prontuario_flutter/config/langs/ptbr.dart";
import "package:prontuario_flutter/infra/api/api_status.dart";
import "package:prontuario_flutter/infra/api/workplace_services.dart";
import "package:prontuario_flutter/infra/models/workplace.dart";
import "package:prontuario_flutter/infra/view_models/user_view_model.dart";
import "package:prontuario_flutter/widgets/appbar.dart";
import "package:prontuario_flutter/widgets/card_widget.dart";
import "package:provider/provider.dart";

class WorkplacePage extends StatefulWidget {
  const WorkplacePage({super.key});

  @override
  State<WorkplacePage> createState() => _WorkplacePageState();
}

class _WorkplacePageState extends State<WorkplacePage> {
  late bool __addPressed = false;
  @override
  void initState() {
    super.initState();
    __addPressed;
  }

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = context.watch<UserViewModel>();

    return Scaffold(
        appBar: customAppBar(context, actionButtonFuntion: () {
          setState(() {
            __addPressed = true;
          });
        }, appbarTitle: WORKPLACE, iconType: 0),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(
          children: [
            Visibility(
              child: _addCardTextField(userViewModel),
              visible: __addPressed,
            ),
            Expanded(child: _ui(userViewModel)),
          ],
        ));
  }

  _ui(UserViewModel usersView) {
    if (usersView.loading) {
      return const CircularProgressIndicator();
    }

    if (usersView.userError != null) {
      return Container();
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: usersView.user!.workplaces!.length,
            itemBuilder: (context, index) {
              Workplace workplace = usersView.user!.workplaces![index];
              return Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 4.0), // Optional margin
                child: MyCardWidget(
                  cardTitle: workplace.name,
                  gestureOnTap: () {
                    // goto patients and send workplace.patiens to the builder
                    context.read<UserViewModel>().setWorkplace(workplace);
                    Navigator.of(context).pushNamed('/patients');
                  },
                  iconOnPress: () async {
                    await WorkplaceServices.deleteWorkplace(
                      usersView.authToken!,
                      workplace.id!,
                    );
                    usersView
                        .getUser(); // Ensure this method doesn't cause side effects
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  _addCardTextField(UserViewModel usersView) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: TextField(
        onSubmitted: (value) async {
          Workplace newPlace = Workplace(
            name: value,
            patients: [],
          );
          // bool res = await createWorkplace(newPlace, authToken);
          var response = await WorkplaceServices.createWorkplace(
            newPlace,
            usersView.authToken!,
          );

          if (response is Failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(WORKPLACE_CREATION_ERROR)),
            );
            return;
          }

          if (response is Success) {
            usersView.getUser();
            setState(() {
              __addPressed = false;
            });
          }
        },
        obscureText: false,
        style: TextStyle(fontSize: 18, color: Colors.grey[900]),
        decoration: InputDecoration(
          labelText: WORKPLACE,
        ),
      ),
    );
  }
}

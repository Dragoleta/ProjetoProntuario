import 'package:flutter/material.dart';
import 'package:prontuario_flutter/helpers/login.dart';
import 'package:prontuario_flutter/infra/localstorage/local_storage.dart';
import 'package:prontuario_flutter/widgets/appbar.dart';

class StartPage extends StatefulWidget {
  final LocalStorage localStorage;
  const StartPage({super.key, required this.localStorage});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context,
          actionButtonFuntion: () async {},
          appbarTitle: 'Starting',
          iconType: 0),
      body: Center(
        child: ElevatedButton(
          child: const Text('Entrar'),
          onPressed: () async {
            bool hasProfessional =
                await checkHasProfessinal(widget.localStorage);

            if (!hasProfessional) {
              Navigator.popAndPushNamed(context, '/loginSignin');
            }

            await loginHelper(widget.localStorage);
            Navigator.popAndPushNamed(context, '/workplaces');

            // List<String>? token = widget.localStorage.getActiveAuthToken();
          },
        ),
      ),
    );
  }
}

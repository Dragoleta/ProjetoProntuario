import 'package:flutter/material.dart';
import 'package:prontuario_flutter/config/langs/ptbr.dart';
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
          appbarTitle: GREETINGS,
          iconType: 3),
      body: Center(
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.primary)),
          child: Text(
            SIGNIN,
            style: TextStyle(color: Theme.of(context).colorScheme.secondary),
          ),
          onPressed: () async {
            await loginHelper(widget.localStorage, context);
          },
        ),
      ),
    );
  }
}

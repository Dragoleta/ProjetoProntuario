import 'package:flutter/material.dart';

class AppBarTemplate extends StatelessWidget {
  final VoidCallback? actionButtonFuntion;
  final String appbarTitle;
  final int iconType;
  const AppBarTemplate(
      {super.key,
      required this.actionButtonFuntion,
      required this.appbarTitle,
      required this.iconType});

  @override
  Widget build(BuildContext context) {
    return customAppBar(context,
        actionButtonFuntion: actionButtonFuntion!,
        appbarTitle: appbarTitle,
        iconType: iconType);
  }
}

AppBar customAppBar(BuildContext context,
    {required VoidCallback? actionButtonFuntion,
    required String appbarTitle,
    required int iconType}) {
  return AppBar(
    title: Text(
      appbarTitle,
      style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 18,
          fontWeight: FontWeight.bold),
    ),
    elevation: 0,
    backgroundColor: Theme.of(context).colorScheme.primary,
    centerTitle: true,
    actions: [actionAppBarIcon(context, actionButtonFuntion, iconType)],
  );
}

Widget actionAppBarIcon(
    BuildContext context, actionButtonFuntion, int iconType) {
  if (iconType == 1) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: actionButtonFuntion,
      tooltip: "Edit this history",
    );
  } else if (iconType == 2) {
    return IconButton(
      icon: const Icon(Icons.done),
      onPressed: actionButtonFuntion,
      tooltip: "Edit this history",
    );
  } else if (iconType == 3) {
    return const SizedBox();
  }
  return IconButton(
    icon: const Icon(Icons.add),
    onPressed: actionButtonFuntion,
    tooltip: "working",
  );
}

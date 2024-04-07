import 'package:flutter/material.dart';

class MyCardWidget extends StatelessWidget {
  final String cardTitle;
  final VoidCallback? gestureOnTap;
  final VoidCallback? iconOnPress;

  const MyCardWidget({
    super.key,
    required this.cardTitle,
    this.gestureOnTap,
    this.iconOnPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: gestureOnTap,
              child: Text(
                cardTitle,
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: iconOnPress,
              tooltip: "Delete this workplace",
            )
          ],
        ),
      ),
    );
  }
}

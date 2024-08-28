import 'package:flutter/material.dart';
import 'package:prontuario_flutter/infra/models/appointment.dart';

Card historyCard({
  required BuildContext context,
  required Appointment appointment,
  required iconOnPress,
  required cardOnPress,
}) {
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
            onTap: cardOnPress,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appointment.appointmentDate,
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                const VerticalDivider(
                  thickness: 10,
                  width: 25,
                ),
                SizedBox(
                  width: 210,
                  child: Text(
                    appointment.text,
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.red,
            onPressed: iconOnPress,
            tooltip: "Delete this patient",
          )
        ],
      ),
    ),
  );
}

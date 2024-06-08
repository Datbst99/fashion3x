import '/Views/Components/button_component.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDiaLog(BuildContext context, String title, String message, {bool navigateHome = false}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          ButtonComponent(
            borderRadius: BorderRadius.circular(20),
            onPressed: () async {
              Navigator.of(context).pop();
              if (navigateHome) {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            },
            child: const Text(
              'Thoát',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      );
    },
  );
}

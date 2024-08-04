import 'package:flutter/material.dart';

import '../constant/kconst.dart';

Future<dynamic> errorDialog(BuildContext context, Object error) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        error.toString(),
        style: Kconst.kTextTheme(context).bodyLarge,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

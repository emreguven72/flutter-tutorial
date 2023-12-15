import 'package:firstproject/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog({
  required BuildContext context,
  required String text,
}) {
  return showGenericDialog<void>(
    context: context,
    title: "An error occured",
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}

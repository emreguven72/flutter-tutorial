import 'package:firstproject/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool?> showDeleteDialog({
  required BuildContext context,
}) {
  return showGenericDialog<bool>(
    context: context,
    title: "Deleting note",
    content: "Are you sure you want to delete this item?",
    optionsBuilder: () => {
      "NO": false,
      "YES": true
    },
  ).then((value) => value ?? false);
}

import 'package:firstproject/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showCannotShareEmptyNoteDialog({
  required BuildContext context,
}) {
  return showGenericDialog<void>(
    context: context,
    title: "Sharing",
    content: "You cannot share an empty note!",
    optionsBuilder: () => {
      'OK': null,
    },
  );
}

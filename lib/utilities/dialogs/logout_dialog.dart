import 'package:firstproject/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool?> showLogoutDialog({
  required BuildContext context,
}) {
  return showGenericDialog<bool>(
    context: context,
    title: "Logout",
    content: "Are you sure you want to logout?",
    optionsBuilder: () => {
      "cancel": false,
      "logout": true,
    },
  ).then((value) => value ?? false);
}

import 'package:flutter/material.dart';

void notesSnackBar(BuildContext context, String toastText, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(8)),
      ),
      content: Text(toastText),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
    ),
  );
}

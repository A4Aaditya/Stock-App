import 'package:flutter/material.dart';

SnackBar customSnackBar({required String text, required Color color}) {
  return SnackBar(
    content: Text(text),
    backgroundColor: color,
  );
}

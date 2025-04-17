import 'package:flutter/material.dart';

//Show notification at bottom of screen in case of given error or message.
void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),);
}



















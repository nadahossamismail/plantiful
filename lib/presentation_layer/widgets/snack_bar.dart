import 'package:flutter/material.dart';

abstract class AppSnackBar {
  static void showSnackBar(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      message,
      style: const TextStyle(fontSize: 18, color: Colors.white),
    )));
  }
}

import 'package:flutter/material.dart';
import 'package:plantiful/core/app_sizing.dart';

class SwitchMethod extends StatelessWidget {
  final String message;
  final String method;
  final String screen;

  const SwitchMethod(
      {super.key,
      required this.message,
      required this.method,
      required this.screen});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(screen);
            },
            child: Text(method, style: const TextStyle(fontSize: FontSize.f16)))
      ],
    );
  }
}

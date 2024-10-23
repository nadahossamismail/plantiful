import 'package:flutter/material.dart';
import 'package:plantiful/core/app_sizing.dart';

class SomethingWentWrong extends StatelessWidget {
  final Function() onPressed;
  const SomethingWentWrong({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: double.infinity,
          child: Text("Something went wrong",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: FontSize.f18)),
        ),
        const SizedBox(
          height: 10,
        ),
        OutlinedButton(
          onPressed: onPressed,
          style: const ButtonStyle(
              padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 12, vertical: 10))),
          child: const Text(
            "Try again",
          ),
        )
      ],
    );
  }
}

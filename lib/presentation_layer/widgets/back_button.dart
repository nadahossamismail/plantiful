import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackButton(
      color: Colors.white,
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.black38)),
    );
  }
}

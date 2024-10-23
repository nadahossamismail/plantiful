import 'package:flutter/material.dart';
import 'package:plantiful/core/app_sizing.dart';

class EmptyList extends StatelessWidget {
  final String text;
  const EmptyList({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: 250,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: FontSize.f20, color: Colors.grey),
      ),
    ));
  }
}

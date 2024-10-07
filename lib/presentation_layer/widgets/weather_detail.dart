import 'package:flutter/material.dart';
import 'package:plantiful/core/app_sizing.dart';

class WeatherDetail extends StatelessWidget {
  final String label;
  final String value;
  const WeatherDetail({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return label == ""
        ? Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(value))),
          )
        : Column(
            children: [
              Text(
                label,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: FontSize.f16,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                value,
                style: const TextStyle(
                    fontSize: FontSize.f24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )
            ],
          );
  }
}

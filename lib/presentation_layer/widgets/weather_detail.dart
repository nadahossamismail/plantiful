import 'package:flutter/material.dart';
import 'package:plantiful/core/app_colors.dart';
import 'package:plantiful/core/app_sizing.dart';

class WeatherDetail extends StatelessWidget {
  final String? label;
  final String value;
  const WeatherDetail({super.key, this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return label == null
        ? value == ""
            ? const SizedBox.shrink()
            : Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(value))),
              )
        : Column(
            children: [
              Text(
                label!,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: FontSize.f14,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                value,
                style: const TextStyle(
                    fontSize: FontSize.f24,
                    color: AppColors.text,
                    fontWeight: FontWeight.bold),
              )
            ],
          );
  }
}

import 'package:flutter/material.dart';
import 'package:plantiful/core/app_colors.dart';
import 'package:plantiful/core/app_sizing.dart';
import 'package:plantiful/cubits/weather/weather_cubit.dart';

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

class WeatherPannel extends StatelessWidget {
  final WeatherSuccess state;

  const WeatherPannel({super.key, required this.state});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          WeatherDetail(
            label: "Temp",
            value: "${state.weather.tempMax!.celsius!.ceil()}\u2103",
          ),
          WeatherDetail(
            label: "Humidity",
            value: "${state.weather.humidity!.ceil()}%",
          ),
          WeatherDetail(
            label: "feels like",
            value: "${state.weather.tempFeelsLike!.celsius!.ceil()}\u2103",
          ),
        ],
      ),
    );
  }
}

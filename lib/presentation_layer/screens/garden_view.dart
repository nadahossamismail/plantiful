import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plantiful/core/app_routes.dart';
import 'package:plantiful/core/app_sizing.dart';
import 'package:plantiful/data_layer.dart/api_requests/get_fertilizers.dart';
import 'package:plantiful/presentation_layer/widgets/weather_detail.dart';

class GardenView extends StatelessWidget {
  const GardenView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: AppSpacingSizing.s24,
                right: AppSpacingSizing.s24,
                bottom: AppSpacingSizing.s12,
                top: AppSpacingSizing.s24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My garden",
                  style: GoogleFonts.ubuntu(
                      textStyle: const TextStyle(
                          fontSize: FontSize.f34,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.5)),
                ),
                Row(
                  children: [
                    const WeatherDetail(
                      label: "",
                      value: "http://openweathermap.org/img/wn/10d@2x.png",
                    ),
                    GestureDetector(
                      child: const CircleAvatar(child: Icon(Icons.person)),
                      onTap: () => GetFertilizersRequest().send(),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacingSizing.s12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WeatherDetail(
                  label: "Temp",
                  value: "25\u2103",
                ),
                WeatherDetail(
                  label: "Humidity",
                  value: "76%",
                ),
                WeatherDetail(
                  label: "feels like",
                  value: "25\u2103",
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(Routes.plantsRoute),
        child: const Icon(Icons.add),
      ),
    ));
  }
}

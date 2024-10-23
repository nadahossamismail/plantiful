import 'package:flutter/material.dart';
import 'package:plantiful/core/app_sizing.dart';

class PlantDetail extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color? color;
  const PlantDetail(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: color,
        size: AppSpacingSizing.s28,
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontSize: FontSize.f18, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
            fontSize: FontSize.f16, fontWeight: FontWeight.w400),
      ),
    );
  }
}

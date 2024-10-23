import 'package:flutter/material.dart';
import 'package:plantiful/core/app_colors.dart';
import 'package:plantiful/core/app_sizing.dart';

class AppMaterialButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final double width;
  final Widget? child;

  const AppMaterialButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.width = double.infinity,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        minWidth: width,
        elevation: AppSpacingSizing.s4,
        height: AppSpacingSizing.s64,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacingSizing.s24)),
        color: AppColors.primary,
        onPressed: onPressed,
        child: child ??
            Text(text,
                style: const TextStyle(
                    fontSize: FontSize.f20, color: AppColors.text)));
  }
}

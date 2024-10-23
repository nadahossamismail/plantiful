import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loading extends StatelessWidget {
  final Color color;
  const Loading({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.waveDots(color: color, size: 34));
  }
}

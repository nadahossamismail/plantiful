import 'package:flutter/material.dart';
import 'package:plantiful/core/app_sizing.dart';

class AppAlertDialog extends StatelessWidget {
  final String message;
  final bool isOneOption;
  final String? actionTitle;
  final Function()? onAction;
  const AppAlertDialog({
    super.key,
    required this.message,
    this.isOneOption = true,
    this.actionTitle,
    this.onAction,
  });

  static void showAlert(context, message) {
    showDialog(
        barrierColor: Colors.grey.withOpacity(0.3),
        context: context,
        builder: (_) => AppAlertDialog(
              message: message,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: const EdgeInsets.symmetric(
            vertical: AppSpacingSizing.s24, horizontal: 24),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacingSizing.s16)),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontSize: FontSize.f18, fontWeight: FontWeight.w500),
        ),
        actions: [
          isOneOption
              ? ActionButton(
                  onPressed: () => Navigator.of(context).pop(),
                  title: "OK",
                  color: Theme.of(context).primaryColor)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ActionButton(
                        onPressed: () => Navigator.of(context).pop(),
                        title: "cancle",
                        color: Colors.grey),
                    const SizedBox(
                      width: 12,
                    ),
                    ActionButton(
                        onPressed: onAction ?? () {},
                        title: actionTitle ?? "OK",
                        color: Theme.of(context).primaryColor)
                  ],
                ),
        ]);
  }
}

class ActionButton extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final Color color;
  const ActionButton({
    super.key,
    required this.onPressed,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onPressed,
        child: Text(title,
            style: TextStyle(fontSize: FontSize.f20, color: color)));
  }
}

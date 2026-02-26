import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    super.key,
  }) : isWide = false;

  const AppButton.wide({
    required this.onPressed,
    required this.child,
    this.isLoading = false,
    super.key,
  }) : isWide = true;

  final bool isLoading;
  final bool isWide;
  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: isLoading
          ? const SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator.adaptive(),
            )
          : child,
    );

    if (isWide) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }
}

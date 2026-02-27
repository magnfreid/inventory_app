import 'package:flutter/material.dart';

enum AppButtonWidth { wrap, wide }

enum AppButtonType { elevated, filled, outlined, text }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.onPressed,
    required this.label,
    AppButtonWidth? width,
    this.isLoading = false,
    super.key,
  }) : _type = .filled,
       _width = width ?? .wide;

  const AppButton.elevated({
    required this.onPressed,
    required this.label,
    AppButtonWidth? width,
    this.isLoading = false,
    super.key,
  }) : _type = .elevated,
       _width = width ?? .wide;

  const AppButton.outlined({
    required this.onPressed,
    required this.label,
    AppButtonWidth? width,
    this.isLoading = false,
    super.key,
  }) : _type = .outlined,
       _width = width ?? .wide;

  const AppButton.text({
    required this.onPressed,
    required this.label,
    AppButtonWidth? width,
    this.isLoading = false,
    super.key,
  }) : _type = .text,
       _width = width ?? .wide;

  final bool isLoading;
  final AppButtonType _type;
  final AppButtonWidth _width;
  final VoidCallback? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? const Center(
            child: SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator.adaptive(),
            ),
          )
        : Text(label.toUpperCase());

    final button = switch (_type) {
      .elevated => ElevatedButton(onPressed: onPressed, child: child),
      .filled => FilledButton(onPressed: onPressed, child: child),
      .outlined => OutlinedButton(onPressed: onPressed, child: child),
      .text => TextButton(onPressed: onPressed, child: child),
    };

    return switch (_width) {
      .wrap => button,
      .wide => SizedBox(
        width: double.infinity,
        child: button,
      ),
    };
  }
}

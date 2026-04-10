import 'package:flutter/material.dart';

/// Semantic category of an app-wide snackbar notification.
///
/// Add a new value here — and a matching case in [_SnackBarConfig.of] — to
/// introduce a new snackbar type. No other changes are required.
enum SnackBarType {
  /// Indicates a successful operation.
  success,

  /// Indicates a failed or erroneous operation.
  error,
}

/// Internal styling config for a [SnackBarType].
///
/// [_SnackBarConfig.of] is the single place that maps types to colors and
/// icons, keeping future additions to one `switch` case.
class _SnackBarConfig {
  const _SnackBarConfig({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
  });

  /// Resolves the config for [type] using the current [ColorScheme].
  ///
  /// Error colors are taken directly from the scheme so they stay in sync
  /// with the app's dynamic theme. Success uses perceptually-balanced fixed
  /// green tones that are legible regardless of the seed color; they are
  /// brightness-aware to support both light and dark mode.
  factory _SnackBarConfig.of(SnackBarType type, ColorScheme scheme) {
    return switch (type) {
      SnackBarType.success => _SnackBarConfig(
          backgroundColor: scheme.brightness == Brightness.light
              ? const Color(0xFFD4EDD4)
              : const Color(0xFF1A3D1A),
          foregroundColor: scheme.brightness == Brightness.light
              ? const Color(0xFF1A4D1A)
              : const Color(0xFFD4EDD4),
          icon: Icons.check_circle_outline,
        ),
      SnackBarType.error => _SnackBarConfig(
          backgroundColor: scheme.errorContainer,
          foregroundColor: scheme.onErrorContainer,
          icon: Icons.error_outline,
        ),
    };
  }

  /// Background color of the snackbar surface.
  final Color backgroundColor;

  /// Color used for the icon and message text.
  final Color foregroundColor;

  /// Leading icon conveying the type at a glance.
  final IconData icon;
}

/// Shows a styled, floating snackbar with an icon and [message].
///
/// Any previously queued snackbars are cleared before showing the new one to
/// prevent stacking when the user triggers multiple operations quickly.
void showAppSnackBar(
  BuildContext context,
  String message,
  SnackBarType type,
) {
  final config = _SnackBarConfig.of(
    type,
    Theme.of(context).colorScheme,
  );

  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        backgroundColor: config.backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        content: Row(
          children: [
            Icon(config.icon, color: config.foregroundColor),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: config.foregroundColor),
              ),
            ),
          ],
        ),
      ),
    );
}

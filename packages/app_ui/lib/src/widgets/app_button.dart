import 'package:flutter/material.dart';

///Setting for button width.
enum AppButtonWidth {
  ///Takes as little width as possible, depending on child's size.
  wrap,

  ///Fills the remaining available width.
  wide,
}

///Setting for [AppButton] type, matches standard Flutter button styles.
enum AppButtonType {
  ///Setting for an elevated [AppButton].
  elevated,

  ///Setting for a filled [AppButton].
  filled,

  ///Settting for an outlined [AppButton]
  outlined,

  ///Setting for a text [AppButton]
  text,
}

///Custom button with a loading indicator (replaces label text while loading)
class AppButton extends StatelessWidget {
  ///Creates a filled [AppButton]
  const AppButton({
    required this.onPressed,
    required this.label,
    AppButtonWidth? width,
    this.isLoading = false,
    this.textStyle,
    this.lowerCased = false,
    super.key,
  }) : _type = .filled,
       _width = width ?? .wrap;

  ///Creates an elevated [AppButton]
  const AppButton.elevated({
    required this.onPressed,
    required this.label,
    AppButtonWidth? width,
    this.isLoading = false,
    this.textStyle,
    this.lowerCased = false,

    super.key,
  }) : _type = .elevated,
       _width = width ?? .wrap;

  ///Creates an outlined [AppButton]
  const AppButton.outlined({
    required this.onPressed,
    required this.label,
    AppButtonWidth? width,
    this.isLoading = false,
    this.textStyle,
    this.lowerCased = false,
    super.key,
  }) : _type = .outlined,
       _width = width ?? .wrap;

  ///Creates a text [AppButton]
  const AppButton.text({
    required this.onPressed,
    required this.label,
    AppButtonWidth? width,
    this.isLoading = false,
    this.textStyle,
    this.lowerCased = false,
    super.key,
  }) : _type = .text,
       _width = width ?? .wrap;

  ///Replaced [AppButton] label text with loading indicator when true.
  final bool isLoading;

  ///Callback for when the [AppButton] is pressed.
  final VoidCallback? onPressed;

  ///The text shown inside the [AppButton].
  final String label;

  ///Optional text style for the button text
  final TextStyle? textStyle;

  ///Can be set to true to override the default uppercased text
  final bool lowerCased;

  final AppButtonWidth _width;
  final AppButtonType _type;

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
        : Text(lowerCased ? label : label.toUpperCase(), style: textStyle);

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

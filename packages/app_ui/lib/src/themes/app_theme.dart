// ignore_for_file: document_ignores, public_member_api_docs

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  const AppTheme({this.seedColor});

  factory AppTheme.light({Color? seedColor}) =>
      _LightTheme(seedColor: seedColor);
  factory AppTheme.dark({Color? seedColor}) =>
      _DarkTheme(seedColor: seedColor);

  final Color? seedColor;

  double get _defaultBorderRadius => 2;

  RoundedRectangleBorder get _defaultShape =>
      RoundedRectangleBorder(borderRadius: .circular(_defaultBorderRadius));

  ThemeData get themeData => ThemeData.from(colorScheme: _colorScheme).copyWith(
    cardTheme: CardThemeData(shape: _defaultShape),
    textTheme: _textTheme,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: _defaultShape,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: _defaultShape,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: _defaultShape,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: _defaultShape,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: _defaultShape,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(_defaultBorderRadius),
      ),
      labelStyle: const TextStyle(fontWeight: .bold),
    ),

    bottomSheetTheme: BottomSheetThemeData(
      shape: _defaultShape,
    ),

    searchBarTheme: SearchBarThemeData(
      shape: WidgetStatePropertyAll(_defaultShape),
    ),
  );

  Color get _defaultSeedColor;

  Brightness get _brightness;

  Color get _effectiveSeedColor => seedColor ?? _defaultSeedColor;

  ColorScheme get _colorScheme => ColorScheme.fromSeed(
        seedColor: _effectiveSeedColor,
        brightness: _brightness,
      );

  TextTheme get _textTheme => GoogleFonts.oswaldTextTheme(
    ThemeData.from(colorScheme: _colorScheme).textTheme,
  );
}

final class _LightTheme extends AppTheme {
  const _LightTheme({super.seedColor});

  @override
  Color get _defaultSeedColor => Colors.blueGrey;

  @override
  Brightness get _brightness => .light;
}

final class _DarkTheme extends AppTheme {
  const _DarkTheme({super.seedColor});

  @override
  Color get _defaultSeedColor => Colors.blueAccent;

  @override
  Brightness get _brightness => .dark;
}

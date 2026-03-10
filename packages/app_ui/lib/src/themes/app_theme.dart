// ignore_for_file: document_ignores, public_member_api_docs

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  const AppTheme();

  factory AppTheme.light() => const _LightTheme();
  factory AppTheme.dark() => const _DarkTheme();

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

  Color get _color;

  Brightness get _brightness;

  ColorScheme get _colorScheme =>
      ColorScheme.fromSeed(seedColor: _color, brightness: _brightness);

  TextTheme get _textTheme => GoogleFonts.oswaldTextTheme(
    ThemeData.from(colorScheme: _colorScheme).textTheme,
  );
}

final class _LightTheme extends AppTheme {
  const _LightTheme();

  @override
  Color get _color => Colors.blueGrey;

  @override
  Brightness get _brightness => .light;
}

final class _DarkTheme extends AppTheme {
  const _DarkTheme();

  @override
  Color get _color => Colors.blueAccent;

  @override
  Brightness get _brightness => .dark;
}

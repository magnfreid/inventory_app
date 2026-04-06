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

  /// Neutral surface colors that don't tint with the accent/seed color.
  ColorScheme get _colorScheme {
    final seeded = ColorScheme.fromSeed(
      seedColor: _effectiveSeedColor,
      brightness: _brightness,
    );
    return seeded.copyWith(
      surface: _neutralSurface,
      surfaceContainerLowest: _neutralSurfaceContainerLowest,
      surfaceContainerLow: _neutralSurfaceContainerLow,
      surfaceContainer: _neutralSurfaceContainer,
      surfaceContainerHigh: _neutralSurfaceContainerHigh,
      surfaceContainerHighest: _neutralSurfaceContainerHighest,
    );
  }

  Color get _neutralSurface;
  Color get _neutralSurfaceContainerLowest;
  Color get _neutralSurfaceContainerLow;
  Color get _neutralSurfaceContainer;
  Color get _neutralSurfaceContainerHigh;
  Color get _neutralSurfaceContainerHighest;

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

  @override
  Color get _neutralSurface => const Color(0xFFFBFBFB);

  @override
  Color get _neutralSurfaceContainerLowest => const Color(0xFFFFFFFF);

  @override
  Color get _neutralSurfaceContainerLow => const Color(0xFFF5F5F5);

  @override
  Color get _neutralSurfaceContainer => const Color(0xFFEEEEEE);

  @override
  Color get _neutralSurfaceContainerHigh => const Color(0xFFE8E8E8);

  @override
  Color get _neutralSurfaceContainerHighest => const Color(0xFFE0E0E0);
}

final class _DarkTheme extends AppTheme {
  const _DarkTheme({super.seedColor});

  @override
  Color get _defaultSeedColor => Colors.blueAccent;

  @override
  Brightness get _brightness => .dark;

  @override
  Color get _neutralSurface => const Color(0xFF1C1B1F);

  @override
  Color get _neutralSurfaceContainerLowest => const Color(0xFF0F0D13);

  @override
  Color get _neutralSurfaceContainerLow => const Color(0xFF1D1B20);

  @override
  Color get _neutralSurfaceContainer => const Color(0xFF211F26);

  @override
  Color get _neutralSurfaceContainerHigh => const Color(0xFF2B2930);

  @override
  Color get _neutralSurfaceContainerHighest => const Color(0xFF36343B);
}

import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: const Color(0xFFF57C00),
    onPrimary: const Color(0xFFffffff),
    primaryContainer: const Color(0xFFffdad2),
    onPrimaryContainer: const Color(0xFF723426),
    inversePrimary: const Color(0xFFffb4a3),

    secondary: const Color(0xFFFF5252),
    onSecondary: const Color(0xFFffffff),
    secondaryContainer: const Color(0xFFffdad2),
    onSecondaryContainer: const Color(0xFF5d3f38),

    error: const Color(0xFFba1a1a),
    onError: const Color(0xFFffffff),
    errorContainer: const Color(0xFFffdad6),
    onErrorContainer: const Color(0xFF93000a),

    surface: const Color(0xFFF6CCB1),
    surfaceContainerLowest: const Color(0xFFffffff),
    surfaceContainerLow: const Color(0xFFfff1ea),
    surfaceContainer: const Color(0xFFfcebe2),
    surfaceContainerHigh: const Color(0xFFf6e5dc),
    surfaceContainerHighest: const Color(0xFFf0dfd7),
    surfaceDim: const Color(0xFFe8d6d2),
    surfaceBright: const Color(0xFFfff8f6),
    inverseSurface: const Color(0xFF392e2c),
    onInverseSurface: const Color(0xFFffede9),
    onSurface: const Color(0xFF231917),
    onSurfaceVariant: const Color(0xFF534340),

    outline: const Color(0xFF85736f),
    outlineVariant: const Color(0xFFd8c2bd),

    scrim: const Color(0xFF000000),
    shadow: const Color(0xFF000000),
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: const Color(0xfff68770),
    onPrimary: const Color(0xFF5e1605),
    primaryContainer: const Color(0xFF7e2c1a),
    onPrimaryContainer: const Color(0xFFffdad2),
    inversePrimary: const Color(0xFFf57c00),

    secondary: const Color(0xFFffb4ab),
    onSecondary: const Color(0xFF690005),
    secondaryContainer: const Color(0xFF93000a),
    onSecondaryContainer: const Color(0xFFffdad2),

    error: const Color(0xFFffb4ab),
    onError: const Color(0xFF690005),
    errorContainer: const Color(0xFF93000a),
    onErrorContainer: const Color(0xFFffdad6),

    surface: const Color(0xFF181210),
    surfaceContainerLowest: const Color(0xFF120c0a),
    surfaceContainerLow: const Color(0xFF1a1412),
    surfaceContainer: const Color(0xFF1e1816),
    surfaceContainerHigh: const Color(0xFF292220),
    surfaceContainerHighest: const Color(0xFF342c2a),
    surfaceDim: const Color(0xFF181210),
    surfaceBright: const Color(0xFF3f3735),
    inverseSurface: const Color(0xFFf0dfd7),
    onInverseSurface: const Color(0xFF392e2c),
    onSurface: const Color(0xFFebd0c9),
    onSurfaceVariant: const Color(0xFFd8c2bd),

    outline: const Color(0xFFa08c88),
    outlineVariant: const Color(0xFF534340),

    scrim: const Color(0xFF000000),
    shadow: const Color(0xFF000000),
  ),
);

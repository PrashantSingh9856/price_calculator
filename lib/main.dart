import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/theme_provider.dart';
import 'screens/calculator_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: PriceCalculatorApp(),
    ),
  );
}

class PriceCalculatorApp extends ConsumerWidget {
  const PriceCalculatorApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Price Calculator',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      home: const CalculatorScreen(),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      colorScheme: const ColorScheme.light(
        surface: Colors.white,
        primary: Color(0xFF3B82F6),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFF1F2937)),
        bodyMedium: TextStyle(color: Color(0xFF4B5563)),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0E1117),
      colorScheme: const ColorScheme.dark(
        surface: Color(0xFF161B22),
        primary: Color(0xFF3B82F6),
        onSurface: Color(0xFFE5E7EB),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xFFE5E7EB)),
        bodyMedium: TextStyle(color: Color(0xFF9CA3AF)),
      ),
      dividerColor: const Color(0xFF2A2F3A),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF161B22),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'calculation_mode.dart';

class CalculatorState {
  final CalculationMode mode;
  final String pricePerKgText; // Changed from double to String
  final String inputValue;
  final double? result;

  const CalculatorState({
    required this.mode,
    required this.pricePerKgText,
    required this.inputValue,
    this.result,
  });

  // Initial state
  factory CalculatorState.initial() {
    return const CalculatorState(
      mode: CalculationMode.amountToGrams,
      pricePerKgText: '',
      inputValue: '',
      result: null,
    );
  }

  // Immutable copy with updates
  CalculatorState copyWith({
    CalculationMode? mode,
    String? pricePerKgText,
    String? inputValue,
    double? result,
    bool clearResult = false,
  }) {
    return CalculatorState(
      mode: mode ?? this.mode,
      pricePerKgText: pricePerKgText ?? this.pricePerKgText,
      inputValue: inputValue ?? this.inputValue,
      result: clearResult ? null : (result ?? this.result),
    );
  }

  // Get accent color based on mode
  Color get accentColor {
    switch (mode) {
      case CalculationMode.amountToGrams:
        return const Color(0xFF3B82F6); // Blue
      case CalculationMode.gramsToAmount:
        return const Color(0xFF8B5CF6); // Purple
    }
  }

  // Get price as double for calculations
  double get pricePerKg {
    final price = double.tryParse(pricePerKgText);
    return price ?? 0;
  }

  // Calculate result based on mode
  double? calculateResult() {
    final price = pricePerKg;
    if (price <= 0 || inputValue.isEmpty) {
      return null;
    }

    final input = double.tryParse(inputValue);
    if (input == null || input <= 0) {
      return null;
    }

    switch (mode) {
      case CalculationMode.amountToGrams:
        // grams = (amount / pricePerKg) * 1000
        return (input / price) * 1000;
      case CalculationMode.gramsToAmount:
        // amount = (grams * pricePerKg) / 1000
        return (input * price) / 1000;
    }
  }
}

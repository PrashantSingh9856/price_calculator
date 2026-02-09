import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/calculator_state.dart';
import '../models/calculation_mode.dart';

class CalculatorNotifier extends Notifier<CalculatorState> {
  static const String _priceKey = 'price_per_kg';

  @override
  CalculatorState build() {
    _loadPricePerKg();
    return CalculatorState.initial();
  }

  // Load persisted price per kg
  Future<void> _loadPricePerKg() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPrice = prefs.getString(_priceKey);
    if (savedPrice != null && savedPrice.isNotEmpty) {
      state = state.copyWith(pricePerKgText: savedPrice);
    }
  }

  // Save price per kg
  Future<void> _savePricePerKg(String price) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_priceKey, price);
  }

  // Set price per kg
  void setPricePerKg(String value) {
    state = state.copyWith(pricePerKgText: value);
    _savePricePerKg(value);
    _recalculate();
  }

  // Set input value
  void setInputValue(String value) {
    state = state.copyWith(inputValue: value);
    _recalculate();
  }

  // Switch calculation mode
  void switchMode(CalculationMode mode) {
    if (state.mode != mode) {
      state = state.copyWith(
        mode: mode,
        inputValue: '',
        clearResult: true,
      );
    }
  }

  // Set preset amount (only for amountToGrams mode)
  void setPresetAmount(double amount) {
    if (state.mode == CalculationMode.amountToGrams) {
      state = state.copyWith(inputValue: amount.toStringAsFixed(0));
      _recalculate();
    }
  }

  // Recalculate result
  void _recalculate() {
    final result = state.calculateResult();
    state = state.copyWith(result: result, clearResult: result == null);
  }
}

// Provider declaration
final calculatorProvider =
    NotifierProvider<CalculatorNotifier, CalculatorState>(
  () => CalculatorNotifier(),
);

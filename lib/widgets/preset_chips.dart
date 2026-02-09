import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/calculation_mode.dart';
import '../providers/calculator_provider.dart';

class PresetChips extends ConsumerWidget {
  const PresetChips({super.key});

  // Amount presets: ₹5 to ₹100 with ₹10 difference
  static const List<double> _amountPresets = [
    5,
    10,
    20,
    30,
    40,
    50,
    60,
    70,
    80,
    90,
    100,
    200,
    300,
    400,
    500
  ];

  // Gram presets: common weights
  static const List<double> _gramPresets = [
    10,
    20,
    30,
    40,
    50,
    60,
    70,
    80,
    90,
    100,
    250,
    500,
    750,
    1000,
    2500
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch only mode
    final mode = ref.watch(calculatorProvider.select((s) => s.mode));
    final accentColor =
        ref.watch(calculatorProvider.select((s) => s.accentColor));

    final presets =
        mode == CalculationMode.amountToGrams ? _amountPresets : _gramPresets;

    final isAmountMode = mode == CalculationMode.amountToGrams;

    return SizedBox(
      height: 70,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: presets.map((value) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _buildPresetChip(
                context,
                ref,
                value,
                isAmountMode,
                accentColor,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildPresetChip(
    BuildContext context,
    WidgetRef ref,
    double value,
    bool isAmountMode,
    Color accentColor,
  ) {
    String label;
    if (isAmountMode) {
      label = '₹${value.toStringAsFixed(0)}';
    } else {
      if (value >= 1000) {
        final kg = value / 1000;
        // Show decimal if not a whole number
        label = kg % 1 == 0
            ? '${kg.toStringAsFixed(0)}kg'
            : '${kg.toStringAsFixed(1)}kg';
      } else {
        label = '${value.toStringAsFixed(0)}g';
      }
    }

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        if (isAmountMode) {
          ref.read(calculatorProvider.notifier).setPresetAmount(value);
        } else {
          ref.read(calculatorProvider.notifier).setInputValue(value.toString());
        }
      },
      child: AnimatedScale(
        scale: 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: 65, // Fixed width for all chips
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: accentColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: accentColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

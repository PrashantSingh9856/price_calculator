import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/calculation_mode.dart';
import '../providers/calculator_provider.dart';

class ResultCard extends ConsumerWidget {
  const ResultCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch only result and mode
    final result = ref.watch(calculatorProvider.select((s) => s.result));
    final mode = ref.watch(calculatorProvider.select((s) => s.mode));

    // Hide if no result
    if (result == null) {
      return const SizedBox.shrink();
    }

    final isAmountMode = mode == CalculationMode.amountToGrams;
    final label = isAmountMode ? 'You should sell:' : 'You should charge:';
    final value = isAmountMode
        ? '${result.toStringAsFixed(2)} grams'
        : '₹${result.toStringAsFixed(2)}';

    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF22C55E),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                color: const Color(0xFF22C55E),
                fontSize: 36,
                fontWeight: FontWeight.w700,
                fontFeatures: const [
                  FontFeature.tabularFigures(),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/calculation_mode.dart';
import '../providers/calculator_provider.dart';

class ModeSelector extends ConsumerWidget {
  const ModeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch only the mode
    final mode = ref.watch(calculatorProvider.select((s) => s.mode));
    final accentColor =
        ref.watch(calculatorProvider.select((s) => s.accentColor));

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildModeButton(
              context: context,
              ref: ref,
              label: 'Amount to Grams',
              mode: CalculationMode.amountToGrams,
              isActive: mode == CalculationMode.amountToGrams,
              accentColor: accentColor,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: _buildModeButton(
              context: context,
              ref: ref,
              label: 'Grams to Amount',
              mode: CalculationMode.gramsToAmount,
              isActive: mode == CalculationMode.gramsToAmount,
              accentColor: accentColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeButton({
    required BuildContext context,
    required WidgetRef ref,
    required String label,
    required CalculationMode mode,
    required bool isActive,
    required Color accentColor,
  }) {
    final buttonAccentColor = mode == CalculationMode.amountToGrams
        ? const Color(0xFF3B82F6) // Blue
        : const Color(0xFF8B5CF6); // Purple

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        ref.read(calculatorProvider.notifier).switchMode(mode);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isActive ? buttonAccentColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isActive
                ? Colors.white
                : Theme.of(context).textTheme.bodyMedium?.color,
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

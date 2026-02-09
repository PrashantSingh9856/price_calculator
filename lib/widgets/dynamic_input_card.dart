import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/calculation_mode.dart';
import '../providers/calculator_provider.dart';

class DynamicInputCard extends ConsumerStatefulWidget {
  const DynamicInputCard({super.key});

  @override
  ConsumerState<DynamicInputCard> createState() => _DynamicInputCardState();
}

class _DynamicInputCardState extends ConsumerState<DynamicInputCard> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch mode, inputValue, and accentColor
    final mode = ref.watch(calculatorProvider.select((s) => s.mode));
    final inputValue =
        ref.watch(calculatorProvider.select((s) => s.inputValue));
    final accentColor =
        ref.watch(calculatorProvider.select((s) => s.accentColor));

    // Update controller if state changes externally
    if (_controller.text != inputValue) {
      _controller.text = inputValue;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }

    final label = mode == CalculationMode.amountToGrams
        ? 'Enter Amount (₹)'
        : 'Enter Weight (grams)';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
            ],
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: '0',
              hintStyle: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.color
                    ?.withOpacity(0.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: accentColor, width: 2),
              ),
            ),
            onChanged: (value) {
              ref.read(calculatorProvider.notifier).setInputValue(value);
            },
          ),
        ],
      ),
    );
  }
}

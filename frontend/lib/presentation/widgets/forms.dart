import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class CounterField extends StatefulWidget {
  final String label;
  final int? initialValue;
  final ValueChanged<int?> onChanged;

  const CounterField({
    super.key,
    required this.label,
    required this.onChanged,
    this.initialValue,
  });

  @override
  State<CounterField> createState() => _CounterFieldState();
}

class _CounterFieldState extends State<CounterField> {
  late TextEditingController _controller;
  int? value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
    _controller = TextEditingController(text: value?.toString() ?? '');
  }

  void _updateValue(int? newValue) {
    final parsedValue = (newValue != null && newValue < 0) ? 0 : newValue;
    setState(() {
      value = newValue;
      _controller.text = value?.toString() ?? '';
    });
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.label),
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  value = (value ?? 0) - 1;
                });
                widget.onChanged(value);
              },
              icon: const Icon(Icons.remove),
            ),
            Text(value?.toString() ?? '0'),
            IconButton(
              onPressed: () {
                setState(() {
                  value = (value ?? 0) + 1;
                });
                widget.onChanged(value);
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}

class NumericTextFormField extends StatelessWidget {
  final String label;
  final String? hint;
  final int? initialValue;
  final ValueChanged<int?> onChanged;

  const NumericTextFormField({
    super.key,
    required this.label,
    required this.onChanged,
    this.hint,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue?.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        filled: true,
        hintText: hint,
        labelText: label,
      ),
      onChanged: (value) {
        final parsedValue = double.tryParse(value);
        if (parsedValue != null) {
          onChanged(parsedValue);
        }
      },
      initialValue: value.toString(),
    );
  }
}

TextFormField(
  decoration: const InputDecoration(
    filled: true,
    hintText: 'Enter a title...',
    labelText: 'Title',
  ),
  onChanged: (value) {
    setState(() {
      title = value;
    });
  },
),
TextFormField(
  decoration: const InputDecoration(
    border: OutlineInputBorder(),
    filled: true,
    hintText: 'Enter a description...',
    labelText: 'Description',
  ),
  onChanged: (value) {
    description = value;
  },
  maxLines: 5,
),
_FormDatePicker(
  date: date,
  onChanged: (value) {
    setState(() {
      date = value;
    });
  },
),
Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Estimated value',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge,
        ),
      ],
    ),
    Text(
      intl.NumberFormat.currency(
        symbol: "\$",
        decimalDigits: 0,
      ).format(maxValue),
      style: Theme.of(
        context,
      ).textTheme.titleMedium,
    ),
    Slider(
      min: 0,
      max: 500,
      divisions: 500,
      value: maxValue,
      onChanged: (value) {
        setState(() {
          maxValue = value;
        });
      },
    ),
  ],
),
Row(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Checkbox(
      value: brushedTeeth,
      onChanged: (checked) {
        setState(() {
          brushedTeeth = checked;
        });
      },
    ),
    Text(
      'Brushed Teeth',
      style: Theme.of(
        context,
      ).textTheme.titleMedium,
    ),
  ],
),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Text(
      'Enable feature',
      style: Theme.of(context).textTheme.bodyLarge,
    ),
    Switch(
      value: enableFeature,
      onChanged: (enabled) {
        setState(() {
          enableFeature = enabled;
        });
      },
    ),
  ],
),

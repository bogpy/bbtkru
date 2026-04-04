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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateValue(int? newValue) {
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
                _updateValue((value ?? 0) - 1);
              },
              icon: const Icon(Icons.remove),
            ),
            Text(value?.toString() ?? '0'),
            IconButton(
              onPressed: () {
                _updateValue((value ?? 0) + 1);
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
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const NumericTextFormField({
    super.key,
    required this.label,
    required this.onChanged,
    this.hint,
    this.initialValue,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue?.toString() : null,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        filled: true,
        hintText: hint,
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
      onChanged: (value) {
        final parsedValue = int.tryParse(value);
        onChanged(parsedValue);
      },
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String? hint;
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final int maxLines;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.onChanged,
    this.hint,
    this.initialValue,
    this.maxLines = 1,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        hintText: hint,
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}

class SingleChoiceField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  const SingleChoiceField({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      initialValue: value,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class MultipleChoiceField<T> extends StatelessWidget {
  final String label;
  final List<T> values;
  final List<T> selectedValues;
  final String Function(T) labelBuilder;
  final ValueChanged<List<T>> onChanged;

  const MultipleChoiceField({
    super.key,
    required this.label,
    required this.values,
    required this.selectedValues,
    required this.labelBuilder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: values.map((value) {
            final isSelected = selectedValues.contains(value);
            return FilterChip(
              label: Text(labelBuilder(value)),
              selected: isSelected,
              onSelected: (selected) {
                final newSelection = List<T>.from(selectedValues);
                if (selected) {
                  newSelection.add(value);
                } else {
                  newSelection.remove(value);
                }
                onChanged(newSelection);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

class SearchableMultiChoiceField<T> extends StatefulWidget {
  final String label;
  final List<T> values;
  final List<T> selectedValues;
  final String Function(T) labelBuilder;
  final ValueChanged<List<T>> onChanged;
  final double height;

  const SearchableMultiChoiceField({
    super.key,
    required this.label,
    required this.values,
    required this.selectedValues,
    required this.labelBuilder,
    required this.onChanged,
    this.height = 250,
  });

  @override
  State<SearchableMultiChoiceField<T>> createState() => _SearchableMultiChoiceFieldState<T>();
}

class _SearchableMultiChoiceFieldState<T> extends State<SearchableMultiChoiceField<T>> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredValues = widget.values
        .where((v) => widget.labelBuilder(v).toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search ${widget.label.toLowerCase()}...',
            prefixIcon: const Icon(Icons.search, size: 20),
            isDense: true,
            border: const OutlineInputBorder(),
            filled: true,
          ),
          onChanged: (val) => setState(() => _query = val),
        ),
        const SizedBox(height: 12),
        Container(
          constraints: BoxConstraints(maxHeight: widget.height),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: filteredValues.map((item) {
                final isSelected = widget.selectedValues.contains(item);
                return FilterChip(
                  label: Text(widget.labelBuilder(item)),
                  selected: isSelected,
                  onSelected: (selected) {
                    final newSelection = List<T>.from(widget.selectedValues);
                    if (selected) {
                      newSelection.add(item);
                    } else {
                      newSelection.remove(item);
                    }
                    widget.onChanged(newSelection);
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class DatePickerField extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const DatePickerField({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (date != null) {
          onDateSelected(date);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          border: const OutlineInputBorder(),
        ),
        child: Text(
          selectedDate == null ? 'Select Date' : intl.DateFormat('yyyy-MM-dd').format(selectedDate!),
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 15),
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

class CustomForm extends StatefulWidget {
  const CustomForm({super.key});

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  String title = '';
  String description = '';
  DateTime? date;
  double maxValue = 0;
  bool brushedTeeth = false;
  bool enableFeature = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          label: 'Title',
          hint: 'Enter a title...',
          onChanged: (value) {
            setState(() {
              title = value;
            });
          },
        ),
        const SizedBox(height: 16),
        CustomTextFormField(
          label: 'Description',
          hint: 'Enter a description...',
          maxLines: 5,
          onChanged: (value) {
            setState(() {
              description = value;
            });
          },
        ),
        const SizedBox(height: 16),
        DatePickerField(
          label: 'Select Date',
          selectedDate: date,
          onDateSelected: (newDate) {
            setState(() {
              date = newDate;
            });
          },
        ),
        const SizedBox(height: 16),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Estimated value',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            Text(
              intl.NumberFormat.currency(
                symbol: "\$",
                decimalDigits: 0,
              ).format(maxValue),
              style: Theme.of(context).textTheme.titleMedium,
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
                  brushedTeeth = checked ?? false;
                });
              },
            ),
            Text(
              'Brushed Teeth',
              style: Theme.of(context).textTheme.titleMedium,
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
      ],
    );
  }
}

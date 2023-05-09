import 'package:flutter/material.dart';

Widget buildUnitCard(
  ThemeData theme,
  String inputUnitLabel,
  String outputUnitLabel,
  String selectedInput,
  String selectedOutput,
  Function(String?) onInputChanged,
  Function(String?) onOutputChanged,
  List<String> units,
) {
  return Card(
    elevation: 4,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildUnitDropdown(
              theme, inputUnitLabel, selectedInput, onInputChanged, units),
          const SizedBox(width: 16),
          buildUnitDropdown(
              theme, outputUnitLabel, selectedOutput, onOutputChanged, units),
        ],
      ),
    ),
  );
}

Widget buildUnitDropdown(ThemeData theme, String hint, String value,
    void Function(String?) onChanged, List<String> units) {
  return Expanded(
    flex: 1,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hint, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        InputDecorator(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          child: DropdownButton<String>(
            isExpanded: true,
            hint: Text(hint),
            value: value,
            onChanged: onChanged,
            items: units.map<DropdownMenuItem<String>>(
              (String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              },
            ).toList(),
          ),
        ),
      ],
    ),
  );
}

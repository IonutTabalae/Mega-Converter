import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:units_converter/units_converter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets.dart';

class SpeedPage extends StatefulWidget {
  @override
  State<SpeedPage> createState() => _SpeedPageState();
}

class _SpeedPageState extends State<SpeedPage> {
  SharedPreferences? _prefs;
  String selectedInputUnit = 'm/s';
  String selectedOutputUnit = 'km/h';
  String outputValue = '0';

  final TextEditingController inputValueController =
      TextEditingController(); // Create a TextEditingController

  final Speed speed = Speed();

  final List<String> _units = [];

  @override
  void initState() {
    super.initState();
    _units.addAll(speed.mapSymbols!.values);
    _initPrefs();
    _setLastConversion();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initPrefs();
  }

  void _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    _setLastConversion();
  }

  void _setLastConversion() {
    final double? lastInputValue = _prefs?.getDouble('speed_inputValue');
    final String? lastSelectedInputUnit =
        _prefs?.getString('speed_selectedInputUnit');
    final String? lastSelectedOutputUnit =
        _prefs?.getString('speed_selectedOutputUnit');
    final double? lastConvertedValue =
        _prefs?.getDouble('speed_convertedValue');

    if (lastInputValue != null &&
        lastSelectedInputUnit != null &&
        lastSelectedOutputUnit != null &&
        lastConvertedValue != null) {
      setState(() {
        inputValueController.text = lastInputValue.toString();
        selectedInputUnit = lastSelectedInputUnit;
        selectedOutputUnit = lastSelectedOutputUnit;
        outputValue = lastConvertedValue.toStringAsFixed(3);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildUnitCardWrapper(theme),
            const SizedBox(height: 16),
            _buildInputValueTextField(),
            const SizedBox(height: 16),
            _buildOutputValueField(),
            const SizedBox(height: 16),
            _buildConvertButton(),
          ],
        ),
      ),
    );
  }

  Widget buildUnitCardWrapper(ThemeData theme) {
    return buildUnitCard(
      theme,
      'Input Unit:',
      'Output Unit:',
      selectedInputUnit,
      selectedOutputUnit,
      (String? newValue) {
        setState(() {
          selectedInputUnit = newValue!;
        });
      },
      (String? newValue) {
        setState(() {
          selectedOutputUnit = newValue!;
        });
      },
      _units,
    );
  }

  Widget _buildInputValueTextField() {
    return TextField(
      controller: inputValueController,
      decoration: InputDecoration(
        labelText: 'Enter Value',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
      ],
    );
  }

  Widget _buildOutputValueField() {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(7.0),
        border: Border.all(
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
        ),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Result: ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: '$outputValue ',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: selectedOutputUnit,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConvertButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _convertUnits,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Convert',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  void _convertUnits() {
    double inputValue = double.tryParse(inputValueController.text) ?? 0;
    var inputUnit = SPEED.values
        .firstWhere((unit) => speed.mapSymbols![unit] == selectedInputUnit);
    var outputUnit = SPEED.values
        .firstWhere((unit) => speed.mapSymbols![unit] == selectedOutputUnit);

    var convertedValue = inputValue.convertFromTo(inputUnit, outputUnit);

    setState(() {
      outputValue = convertedValue?.toStringAsFixed(4) ?? '0';
    });
    _prefs?.setDouble('speed_inputValue', inputValue);
    _prefs?.setString('speed_selectedInputUnit', selectedInputUnit);
    _prefs?.setString('speed_selectedOutputUnit', selectedOutputUnit);
    _prefs?.setDouble('speed_convertedValue', convertedValue ?? 0);
  }
}

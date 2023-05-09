import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forex_conversion/forex_conversion.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets.dart';

class CurrencyConversionPage extends StatefulWidget {
  @override
  State<CurrencyConversionPage> createState() => _CurrencyConversionPageState();
}

class _CurrencyConversionPageState extends State<CurrencyConversionPage> {
  SharedPreferences? _prefs;

  final TextEditingController inputValueController =
      TextEditingController(); // Create a TextEditingController
  final fx = Forex();
  List<String> _currencies = [];
  String selectedInputCurrency = 'USD';
  String selectedOutputCurrency = 'USD';
  String outputValue = '0';

  @override
  void initState() {
    super.initState();
    _initPrefs();
    _fetchCurrencies();
    _setLastConversion();
  }

  void _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    _setLastConversion();
  }

  void _setLastConversion() {
    final double? lastInputValue = _prefs?.getDouble('currency_inputValue');
    final String? lastSelectedInputCurrency =
        _prefs?.getString('currency_selectedInputCurrency');
    final String? lastSelectedOutputCurrency =
        _prefs?.getString('currency_selectedOutputCurrency');
    final double? lastConvertedValue =
        _prefs?.getDouble('currency_convertedValue');

    if (lastInputValue != null &&
        lastSelectedInputCurrency != null &&
        lastSelectedOutputCurrency != null &&
        lastConvertedValue != null) {
      setState(() {
        inputValueController.text = lastInputValue.toString();
        selectedInputCurrency = lastSelectedInputCurrency;
        selectedOutputCurrency = lastSelectedOutputCurrency;
        outputValue = lastConvertedValue.toStringAsFixed(3);
      });
    }
  }

  void _fetchCurrencies() async {
    List<String> availableCurrencies = await fx.getAvailableCurrencies();
    setState(() {
      _currencies = availableCurrencies;
    });
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
            const SizedBox(height: 25),
            _buildInputValueTextField(),
            const SizedBox(height: 25),
            _buildOutputValueField(),
            const SizedBox(height: 25),
            _buildConvertButton(),
          ],
        ),
      ),
    );
  }

  Widget buildUnitCardWrapper(theme) {
    return buildUnitCard(theme, 'Input Currency:', 'Output Currency:',
        selectedInputCurrency, selectedOutputCurrency, (String? newValue) {
      setState(() {
        selectedInputCurrency = newValue!;
      });
    }, (String? newValue) {
      setState(() {
        selectedOutputCurrency = newValue!;
      });
    }, _currencies);
  }

  Widget _buildInputValueTextField() {
    return TextField(
      controller: inputValueController,
      decoration: InputDecoration(
        labelText: 'Enter Amount',
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
              text:
                  '$outputValue ', // Replace '0' with the actual converted value
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: selectedOutputCurrency, // Add the converted currency
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
        onPressed: _convertCurrency,
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

  void _convertCurrency() async {
    double inputValue = double.tryParse(inputValueController.text) ?? 0;

    double convertedValue = await fx.getCurrencyConverted(
        sourceCurrency: selectedInputCurrency,
        destinationCurrency: selectedOutputCurrency,
        sourceAmount: inputValue);

    setState(() {
      outputValue = convertedValue.toStringAsFixed(3);
    });

    // Store last rates and converted values in SharedPreferences
    _prefs?.setDouble('currency_inputValue', inputValue);
    _prefs?.setString('currency_selectedInputCurrency', selectedInputCurrency);
    _prefs?.setString(
        'currency_selectedOutputCurrency', selectedOutputCurrency);
    _prefs?.setDouble('currency_convertedValue', convertedValue);
  }
}

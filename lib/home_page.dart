import 'package:flutter/material.dart';
import 'digital_storage_page.dart';
import 'length_page.dart';
import 'weight_page.dart';
import 'pressure_page.dart';
import 'temperature_page.dart';
import 'time_page.dart';
import 'speed_page.dart';
import 'currency_conversion_page.dart';
import 'home.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  var selectedIndex = 0;

  final List<String> _titleList = [
    'Home',
    'Length',
    'Digital Storage',
    'Weight',
    'Pressure',
    'Temperature',
    'Time',
    'Speed',
    'Currency'
  ];

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = Home();
        break;
      case 1:
        page = LengthPage();
        break;
      case 2:
        page = DigitalStoragePage();
        break;
      case 3:
        page = WeightPage();
        break;
      case 4:
        page = PressurePage();
        break;
      case 5:
        page = TemperaturePage();
        break;
      case 6:
        page = TimePage();
        break;
      case 7:
        page = SpeedPage();
        break;
      case 8:
        page = CurrencyConversionPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titleList[selectedIndex], // set the title based on the selectedIndex
        ),
      ),
      body: page,
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.straighten),
                title: Text('Length'),
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.sd_storage),
                title: Text('Digital Storage'),
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.scale),
                title: Text('Weight'),
                onTap: () {
                  setState(() {
                    selectedIndex = 3;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.compress),
                title: Text('Pressure'),
                onTap: () {
                  setState(() {
                    selectedIndex = 4;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.thermostat),
                title: Text('Temperature'),
                onTap: () {
                  setState(() {
                    selectedIndex = 5;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.timelapse),
                title: Text('Time'),
                onTap: () {
                  setState(() {
                    selectedIndex = 6;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.speed),
                title: Text('Speed'),
                onTap: () {
                  setState(() {
                    selectedIndex = 7;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.currency_exchange),
                title: Text('Currency'),
                onTap: () {
                  setState(() {
                    selectedIndex = 8;
                  });
                  Navigator.pop(context);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

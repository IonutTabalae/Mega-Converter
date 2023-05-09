import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // App Title
              Text(
                'MegaConverter',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              SizedBox(height: 24),
              // Lottie Animation
              SizedBox(
                width: 380,
                height: 380,
                child: Lottie.asset('assets/110167-calculator.json'),
              ),
              SizedBox(height: 24),
              // App Description
              Text(
                'Your All-in-One Conversion Solution',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              SizedBox(height: 10),
              Text(
                'Easily convert units, currencies, and more with our simple-to-use app. MegaConverter is designed to make your life easier and your calculations more accurate.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

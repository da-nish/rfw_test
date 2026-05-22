import 'package:flutter/material.dart';
import 'package:flutter_rfw_test/home/home_screen.dart';


// import 'package:my_app/default_stac_options.dart';

void main() async {
  // Initialize Stac with optional custom configurations
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RFW',
      // Pass a routeName to load your dynamic SDUI screen!
      home: FintechHomeScreen(),
    );
  }
}

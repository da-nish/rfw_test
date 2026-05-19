import 'package:flutter/material.dart';
import 'package:test_stac/example/example1.dart';
import 'package:test_stac/example/example2.dart';
import 'package:test_stac/example/example3.dart';
import 'package:test_stac/example/example4.dart';
import 'package:test_stac/home/home_screen.dart';


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



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicScreen();
    Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Hello"),
          // SizedBox(
          //   height: 200,
          //   width: 200,
          //   child: Example()),

          // SizedBox(
          //   height: 200,
          //   width: 200,
          //   child: Example2()),
          // SizedBox(
          //   height: 200,
          //   width: 200,
          //   child: Example3())
          SizedBox(
            height: 400,
            width: double.maxFinite,
            child: DynamicScreen())
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:stac/stac.dart';

// import 'package:my_app/default_stac_options.dart';

void main() async {
  // Initialize Stac with optional custom configurations
  await Stac.initialize(options: StacOptions(name: "sdfsf", projectId: "projectId"));
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stac App',
      // Pass a routeName to load your dynamic SDUI screen!
      home: Stac(routeName: 'get_started'),
    );
  }
}
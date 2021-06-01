import 'DailyNutrition.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nutrition Calculator',
      theme: ThemeData(
        primaryColor: Colors.grey[100],
        accentColor: Colors.green[200],
      ),
      home: DailyNutrition(),
    );
  }
}




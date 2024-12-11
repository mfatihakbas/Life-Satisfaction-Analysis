import 'package:flutter/material.dart';
import 'chart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Veri Grafikleri',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ChartScreen(),
    );
  }
}

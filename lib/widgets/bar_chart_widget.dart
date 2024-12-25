import 'package:flutter/material.dart';

class BarChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 400,
        height: 832,
        color: Colors.blueGrey, // Dikdörtgen rengi
        child: Center(
          child: Text(
            '400 x 832 dp',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

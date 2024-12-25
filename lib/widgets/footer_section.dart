import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple,
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      child: const Text(
        "",
        style: TextStyle(color: Colors.white, fontSize: 14),
        textAlign: TextAlign.left,
      ),
    );
  }
}

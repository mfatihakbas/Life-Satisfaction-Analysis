import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bar_chart_widget.dart';
import '../widgets/filter_section.dart';
import '../widgets/footer_section.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // Özel AppBar
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300, // Grafik için sabit bir yükseklik
              child: BarChartWidget(),
            ),
            FilterSection(), // Filtreleme bölümü
            FooterSection(), // Footer bölümü
          ],
        ),
      ),
    );
  }
}


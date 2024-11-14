import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> data = []; // Api verileri
  bool tekYilGoster = false;
  int? selectedYear; // nullable int (Primary Key)
  List<int> years = List<int>.generate(21, (index) => 2003 + index);
  int baslangicYili = 2003;
  int bitisYili = 2023;

  @override
  void initState() {
    super.initState();
    fetchData(); // Veri çekiliyor
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:5000/api/mutluluk_verisi')); //GET isteği

    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    } else {
      throw Exception('Data fetching error!');
    }
  }

  List<ChartData> getChartData() { // Grafik
    List<ChartData> chartData = [];
    for (var entry in data) {
      int yil = entry['yil'];
      if ((tekYilGoster && yil == selectedYear) ||
          (!tekYilGoster && yil >= baslangicYili && yil <= bitisYili)) {
        chartData.add(ChartData(
          yil.toString(),
          entry['cok_mutlu'],
          entry['mutlu'],
          entry['orta'],
          entry['mutsuz'],
          entry['cok_mutsuz'],
        ));
      }
    }
    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mutluluk Verisi Grafiği'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  title: ChartTitle(text: 'Genel Mutluluk Düzeyi'),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries>[
                    ColumnSeries<ChartData, String>(
                      dataSource: getChartData(),
                      xValueMapper: (ChartData data, _) => data.year,
                      yValueMapper: (ChartData data, _) => data.cokMutlu,
                      name: 'Çok Mutlu',
                      color: Colors.blue,
                    ),
                    ColumnSeries<ChartData, String>(
                      dataSource: getChartData(),
                      xValueMapper: (ChartData data, _) => data.year,
                      yValueMapper: (ChartData data, _) => data.mutlu,
                      name: 'Mutlu',
                      color: Colors.green,
                    ),
                    ColumnSeries<ChartData, String>(
                      dataSource: getChartData(),
                      xValueMapper: (ChartData data, _) => data.year,
                      yValueMapper: (ChartData data, _) => data.orta,
                      name: 'Orta',
                      color: Colors.orange,
                    ),
                    ColumnSeries<ChartData, String>(
                      dataSource: getChartData(),
                      xValueMapper: (ChartData data, _) => data.year,
                      yValueMapper: (ChartData data, _) => data.mutsuz,
                      name: 'Mutsuz',
                      color: Colors.red,
                    ),
                    ColumnSeries<ChartData, String>(
                      dataSource: getChartData(),
                      xValueMapper: (ChartData data, _) => data.year,
                      yValueMapper: (ChartData data, _) => data.cokMutsuz,
                      name: 'Çok Mutsuz',
                      color: Colors.purple,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<int>(
                    value: baslangicYili,
                    onChanged: (value) {
                      setState(() {
                        baslangicYili = value!;
                      });
                    },
                    items: years.map((int year) {
                      return DropdownMenuItem<int>(
                        value: year,
                        child: Text(year.toString()),
                      );
                    }).toList(),
                  ),
                  const SizedBox(width: 20),
                  DropdownButton<int>(
                    value: bitisYili,
                    onChanged: (value) {
                      setState(() {
                        bitisYili = value!;
                      });
                    },
                    items: years.map((int year) {
                      return DropdownMenuItem<int>(
                        value: year,
                        child: Text(year.toString()),
                      );
                    }).toList(),
                  ),
                  const SizedBox(width: 20),
                  Checkbox(
                    value: tekYilGoster,
                    onChanged: (value) {
                      setState(() {
                        tekYilGoster = value!;
                      });
                    },
                  ),
                  const Text('Tek Yıl Göster'),
                  if (tekYilGoster)
                    DropdownButton<int>(
                      value: selectedYear,
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value!;
                        });
                      },
                      items: years.map((int year) {
                        return DropdownMenuItem<int>(
                          value: year,
                          child: Text(year.toString()),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.year, this.cokMutlu, this.mutlu, this.orta, this.mutsuz, this.cokMutsuz);
  final String year;
  final double cokMutlu;
  final double mutlu;
  final double orta;
  final double mutsuz;
  final double cokMutsuz;
}

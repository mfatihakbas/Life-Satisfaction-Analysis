import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'chart_data.dart';
import 'api_service.dart';

class ChartScreen extends StatefulWidget {
  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List<dynamic> data = [];
  bool tekYilGoster = false;
  int? selectedYear;
  List<int> years = List<int>.generate(21, (index) => 2003 + index);
  int baslangicYili = 2003;
  int bitisYili = 2023;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<dynamic> fetchedData = await ApiService.getData();
      setState(() {
        data = fetchedData;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  List<ChartData> getChartData() {
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
    return Scaffold(
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
    );
  }
}

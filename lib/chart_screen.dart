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

  String selectedDataset = 'Mutluluk Verisi';
  final List<String> datasets = [
    'Mutluluk Verisi',
    'Güvenlik Verisi',
    'Kazançtan Memnuniyet'
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<dynamic> fetchedData;
      if (selectedDataset == 'Mutluluk Verisi') {
        fetchedData = await ApiService.getMutlulukData();
      } else if (selectedDataset == 'Güvenlik Verisi') {
        fetchedData = await ApiService.getGuvenlikData();
      } else {
        fetchedData = await ApiService.getKazancData();
      }
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
        if (selectedDataset == 'Mutluluk Verisi') {
          chartData.add(ChartData(
            year: yil.toString(),
            cokMutlu: entry['cok_mutlu'],
            mutlu: entry['mutlu'],
            orta: entry['orta'],
            mutsuz: entry['mutsuz'],
            cokMutsuz: entry['cok_mutsuz'],
          ));
        } else if (selectedDataset == 'Güvenlik Verisi') {
          chartData.add(ChartData(
            year: yil.toString(),
            cokGuvenli: entry['cok_guvenli'],
            guvenli: entry['guvenli'],
            orta: entry['orta'],
            guvensiz: entry['guvensiz'],
            cokGuvensiz: entry['cok_guvensiz'],
          ));
        } else if (selectedDataset == 'Kazançtan Memnuniyet') {
          chartData.add(ChartData(
            year: yil.toString(),
            cokMemnun: entry['cok_memnun'],
            memnun: entry['memnun'],
            orta: entry['orta'],
            memnunDegil: entry['memnun_degil'],
            hicMemnunDegil: entry['hic_memnun_degil'],
            kazanciYok: entry['kazanci_yok'], // Kazancı Yok sütunu eklendi
          ));
        }
      }
    }
    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedDataset), // Dinamik başlık
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Veri Seti:', style: TextStyle(fontSize: 16)),
                DropdownButton<String>(
                  value: selectedDataset,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDataset = newValue!;
                      fetchData();
                    });
                  },
                  items: datasets.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ],
            ),
            Expanded(
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(text: selectedDataset),
                legend: Legend(isVisible: true,
                  overflowMode: LegendItemOverflowMode.wrap,),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries>[
                  if (selectedDataset == 'Mutluluk Verisi') ...[
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
                  ] else if (selectedDataset == 'Güvenlik Verisi') ...[
                    ColumnSeries<ChartData, String>(
                      dataSource: getChartData(),
                      xValueMapper: (ChartData data, _) => data.year,
                      yValueMapper: (ChartData data, _) => data.cokGuvenli,
                      name: 'Çok Güvenli',
                      color: Colors.blue,
                    ),
                    ColumnSeries<ChartData, String>(
                      dataSource: getChartData(),
                      xValueMapper: (ChartData data, _) => data.year,
                      yValueMapper: (ChartData data, _) => data.guvenli,
                      name: 'Güvenli',
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
                      yValueMapper: (ChartData data, _) => data.guvensiz,
                      name: 'Güvensiz',
                      color: Colors.red,
                    ),
                    ColumnSeries<ChartData, String>(
                      dataSource: getChartData(),
                      xValueMapper: (ChartData data, _) => data.year,
                      yValueMapper: (ChartData data, _) => data.cokGuvensiz,
                      name: 'Çok Güvensiz',
                      color: Colors.purple,
                    ),
                  ] else if (selectedDataset == 'Kazançtan Memnuniyet') ...[
                    ColumnSeries<ChartData, String>(
                      dataSource: getChartData(),
                      xValueMapper: (ChartData data, _) => data.year,
                      yValueMapper: (ChartData data, _) => data.cokMemnun,
                      name: 'Çok Memnun',
                      color: Colors.blue,
                    ),
                    ColumnSeries<ChartData, String>(
                      dataSource: getChartData(),
                      xValueMapper: (ChartData data, _) => data.year,
                      yValueMapper: (ChartData data, _) => data.memnun,
                      name: 'Memnun',
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
                      yValueMapper: (ChartData data, _) => data.memnunDegil,
                      name: 'Memnun Değil',
                      color: Colors.red,
                    ),
                    ColumnSeries<ChartData, String>(
                      dataSource: getChartData(),
                      xValueMapper: (ChartData data, _) => data.year,
                      yValueMapper: (ChartData data, _) => data.hicMemnunDegil,
                      name: 'Hiç Memnun Değil',
                      color: Colors.purple,
                    ),
                    ColumnSeries<ChartData, String>(
                      dataSource: getChartData(),
                      xValueMapper: (ChartData data, _) => data.year,
                      yValueMapper: (ChartData data, _) => data.kazanciYok,
                      name: 'Kazancı Yok',
                      color: Colors.grey,
                    ),
                  ],
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

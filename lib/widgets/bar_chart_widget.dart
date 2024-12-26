import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'api_service.dart';

class BarChartWidget extends StatefulWidget {
  const BarChartWidget({Key? key}) : super(key: key);

  @override
  BarChartWidgetState createState() => BarChartWidgetState();
}

class BarChartWidgetState extends State<BarChartWidget> {
  late Future<List<dynamic>> _dataFuture;
  late List<_ChartData> _chartData;

  String _selectedTable = 'Mutluluk Tablosu';

  @override
  void initState() {
    super.initState();
    _dataFuture = ApiService.getMutlulukData(); // Varsayılan veri kaynağı
    _chartData = [];
    _fetchChartData();
  }

  void updateYearFilters(int startYear, int endYear) {
    // Eski verileri sıfırla ve filtreyi uygula
    _fetchChartData().then((_) {
      setState(() {
        _chartData = _chartData.where((item) {
          final year = int.parse(item.year);
          return year >= startYear && year <= endYear;
        }).toList();
      });
    });
  }
   void updateFuture(Future<List<dynamic>> newFuture, String selectedTable) {
    setState(() {
      _dataFuture = newFuture;
      _selectedTable = selectedTable;
      _fetchChartData();
    });
  }

  Future<void> _fetchChartData() async {
    try {
      final data = await _dataFuture;
      setState(() {
        _chartData = data.map((item) {
          switch (_selectedTable) {
            case 'Mutluluk Tablosu':
              return _ChartData(
                year: item['yil'].toString(),
                cokMutlu: item['cok_mutlu']?.toDouble() ?? 0,
                mutlu: item['mutlu']?.toDouble() ?? 0,
                orta: item['orta']?.toDouble() ?? 0,
                mutsuz: item['mutsuz']?.toDouble() ?? 0,
                cokMutsuz: item['cok_mutsuz']?.toDouble() ?? 0,
              );
            case 'Güvenlik Tablosu':
              return _ChartData(
                year: item['yil'].toString(),
                cokGuvenli: item['cok_guvenli']?.toDouble() ?? 0,
                guvenli: item['guvenli']?.toDouble() ?? 0,
                orta: item['orta']?.toDouble() ?? 0,
                guvensiz: item['guvensiz']?.toDouble() ?? 0,
                cokGuvensiz: item['cok_guvensiz']?.toDouble() ?? 0,
              );
            case 'Kazançtan Memnuniyet':
              return _ChartData(
                year: item['yil'].toString(),
                cokMemnun: item['cok_memnun']?.toDouble() ?? 0,
                memnun: item['memnun']?.toDouble() ?? 0,
                orta: item['orta']?.toDouble() ?? 0,
                memnunDegil: item['memnun_degil']?.toDouble() ?? 0,
                hicMemnunDegil: item['hic_memnun_degil']?.toDouble() ?? 0,
                kazanciYok: item['kazanci_yok']?.toDouble() ?? 0,
              );
            case 'Refah Seviyesi':
              return _ChartData(
                year: item['yil'].toString(),
                en_dusuk: item['en_dusuk']?.toDouble() ?? 0,
                dusuk: item['dusuk']?.toDouble() ?? 0,
                orta: item['orta']?.toDouble() ?? 0,
                yuksek: item['yuksek']?.toDouble() ?? 0,
                en_yuksek: item['en_yuksek']?.toDouble() ?? 0,
              );
            default:
              return _ChartData(year: '', orta: 0); // Default boş veri
          }
        }).toList();
      });
    } catch (e) {
      print('Hata: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Hata: ${snapshot.error}',
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'Hiç veri bulunamadı',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          );
        } else {
          return SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(text: 'Seçilen Tablo Verileri'),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: _buildChartSeries(),
          );
        }
      },
    );
  }

  List<ChartSeries<_ChartData, String>> _buildChartSeries() {
    switch (_selectedTable) {
      case 'Mutluluk Tablosu':
        return [
          ColumnSeries<_ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (_ChartData data, _) => data.year,
            yValueMapper: (_ChartData data, _) => data.cokMutlu,
            name: 'Çok Mutlu',
            color: Colors.blue,
          ),
          ColumnSeries<_ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (_ChartData data, _) => data.year,
            yValueMapper: (_ChartData data, _) => data.mutlu,
            name: 'Mutlu',
            color: Colors.green,
          ),
          ColumnSeries<_ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (_ChartData data, _) => data.year,
            yValueMapper: (_ChartData data, _) => data.orta,
            name: 'Orta',
            color: Colors.orange,
          ),
          ColumnSeries<_ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (_ChartData data, _) => data.year,
            yValueMapper: (_ChartData data, _) => data.mutsuz,
            name: 'Mutsuz',
            color: Colors.red,
          ),
          ColumnSeries<_ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (_ChartData data, _) => data.year,
            yValueMapper: (_ChartData data, _) => data.cokMutsuz,
            name: 'Çok Mutsuz',
            color: Colors.purple,
          ),
        ];
      case 'Güvenlik Tablosu':
        return [
          ColumnSeries<_ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (_ChartData data, _) => data.year,
            yValueMapper: (_ChartData data, _) => data.cokGuvenli,
            name: 'Çok Güvenli',
            color: Colors.blue,
          ),
          ColumnSeries<_ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (_ChartData data, _) => data.year,
            yValueMapper: (_ChartData data, _) => data.guvenli,
            name: 'Güvenli',
            color: Colors.green,
          ),
          ColumnSeries<_ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (_ChartData data, _) => data.year,
            yValueMapper: (_ChartData data, _) => data.orta,
            name: 'Orta',
            color: Colors.orange,
          ),
          ColumnSeries<_ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (_ChartData data, _) => data.year,
            yValueMapper: (_ChartData data, _) => data.guvensiz,
            name: 'Güvensiz',
            color: Colors.red,
          ),
          ColumnSeries<_ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (_ChartData data, _) => data.year,
            yValueMapper: (_ChartData data, _) => data.cokGuvensiz,
            name: 'Çok Güvensiz',
            color: Colors.purple,
          ),
        ];
      case 'Kazançtan Memnuniyet':
        return [
          ColumnSeries<_ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (_ChartData data, _) => data.year,
            yValueMapper: (_ChartData data, _) => data.cokMemnun,
            name: 'Çok Memnun',
            color: Colors.blue,
          ),
          ColumnSeries<_ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (_ChartData data, _) => data.year,
            yValueMapper: (_ChartData data, _) => data.memnun,
            name: 'Memnun',
            color: Colors.green,
          ),
          ColumnSeries<_ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (_ChartData data, _) => data.year,
            yValueMapper: (_ChartData data, _) => data.orta,
            name: 'Orta',
            color: Colors.orange,
          ),
          ColumnSeries<_ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (_ChartData data, _) => data.year,
            yValueMapper: (_ChartData data, _) => data.memnunDegil,
            name: 'Memnun Değil',
            color: Colors.red,
          ),
          ColumnSeries<_ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (_ChartData data, _) => data.year,
            yValueMapper: (_ChartData data, _) => data.hicMemnunDegil,
            name: 'Hiç Memnun Değil',
            color: Colors.purple,
          ),
          ColumnSeries<_ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (_ChartData data, _) => data.year,
            yValueMapper: (_ChartData data, _) => data.kazanciYok,
            name: 'Kazancı Yok',
            color: Colors.grey,
          ),
        ];
      case 'Refah Seviyesi':
        return [
          ColumnSeries<_ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (_ChartData data, _) => data.year,
            yValueMapper: (_ChartData data, _) => data.en_yuksek,
            name: 'En Yüksek',
            color: Colors.blue,
          ),
          ColumnSeries<_ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (_ChartData data, _) => data.year,
            yValueMapper: (_ChartData data, _) => data.yuksek,
            name: 'Yüksek',
            color: Colors.green,
          ),
          ColumnSeries<_ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (_ChartData data, _) => data.year,
            yValueMapper: (_ChartData data, _) => data.orta,
            name: 'Orta',
            color: Colors.orange,
          ),
          ColumnSeries<_ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (_ChartData data, _) => data.year,
            yValueMapper: (_ChartData data, _) => data.dusuk,
            name: 'Düşük',
            color: Colors.purple,
          ),
          ColumnSeries<_ChartData, String>(
            dataSource: _chartData,
            xValueMapper: (_ChartData data, _) => data.year,
            yValueMapper: (_ChartData data, _) => data.en_dusuk,
            name: 'En Düşük',
            color: Colors.red,
          ),
        ];
      default:
        return [];
    }
  }
}

class _ChartData {
  _ChartData({
    required this.year,
    this.cokMutlu = 0,
    this.mutlu = 0,
    this.orta = 0,
    this.mutsuz = 0,
    this.cokMutsuz = 0,
    this.cokGuvenli = 0,
    this.guvenli = 0,
    this.guvensiz = 0,
    this.cokGuvensiz = 0,
    this.cokMemnun = 0,
    this.memnun = 0,
    this.memnunDegil = 0,
    this.hicMemnunDegil = 0,
    this.kazanciYok = 0,
    this.en_dusuk=0,
    this.dusuk=0,
    this.yuksek=0,
    this.en_yuksek=0,
  });

  final String year;
  final double cokMutlu;
  final double mutlu;
  final double orta;
  final double mutsuz;
  final double cokMutsuz;
  final double cokGuvenli;
  final double guvenli;
  final double guvensiz;
  final double cokGuvensiz;
  final double cokMemnun;
  final double memnun;
  final double memnunDegil;
  final double hicMemnunDegil;
  final double kazanciYok;
  final double en_dusuk;
  final double dusuk;
  final double yuksek;
  final double en_yuksek;
}

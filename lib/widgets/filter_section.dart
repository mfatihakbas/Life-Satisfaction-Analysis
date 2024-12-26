import 'package:flutter/material.dart';
import 'package:vtysproje/widgets/api_service.dart';
import 'package:vtysproje/widgets/bar_chart_widget.dart';
class FilterSection extends StatefulWidget {

  final GlobalKey<BarChartWidgetState> chartKey;

  const FilterSection({required this.chartKey, Key? key}) : super(key: key);

  @override
  _FilterSectionState createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  // Seçilen başlangıç ve bitiş yılları
  String? selectedStartYear = '2003';
  String? selectedEndYear = '2022';

  // Checkbox kontrolü
  bool showSingleYear = false;

  // Tablolar için checkbox durumları
  bool isCheckedA = false;
  bool isCheckedB = false;
  bool isCheckedC = false;
  bool isCheckedD = false;

  // Yıl listesi
  final List<String> years = [
    '2003',
    '2004',
    '2005',
    '2006',
    '2007',
    '2008',
    '2009',
    '2010',
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022',
    '2023',
  ];

  // En az bir checkbox işaretli olmalı
  void validateCheckboxes() {
    final checkboxes = [isCheckedA, isCheckedB, isCheckedC, isCheckedD];
    if (!checkboxes.contains(true)) {
      setState(() {
        isCheckedA = true; // Varsayılan olarak A işaretlenir.
      });
    }
  }

  void applyStatisticsFilters() {
    final selectedFilters = [];

    if (isCheckedA) selectedFilters.add("A");
    if (isCheckedB) selectedFilters.add("B");
    if (isCheckedC) selectedFilters.add("C");
    if(isCheckedD) selectedFilters.add("D");
    if (selectedFilters.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("En az bir seçenek seçilmelidir.")),
      );
      return;
    }

    // Seçilen filtreye göre BarChartWidget'ın veri kaynağını güncelle
    if (selectedFilters.contains("A")) {
      widget.chartKey.currentState?.updateFuture(ApiService.getMutlulukData(),"Mutluluk Tablosu");
    } else if (selectedFilters.contains("B")) {
      widget.chartKey.currentState?.updateFuture(ApiService.getGuvenlikData(),"Güvenlik Tablosu");
    } else if (selectedFilters.contains("C")) {
      widget.chartKey.currentState?.updateFuture(ApiService.getKazancData(),"Kazançtan Memnuniyet");
    }
    else if(selectedFilters.contains("D"))
    {
      widget.chartKey.currentState?.updateFuture(ApiService.getRefahData(),"Refah Seviyesi");
    }
  }



  // Yıl filtrelerini uygula butonu işlemi
  void applyYearFilters() {
    if (int.parse(selectedStartYear!) > int.parse(selectedEndYear!)) {
      // Hata mesajı
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Başlangıç yılı, bitiş yılından büyük olamaz."),
        ),
      );
      return;
    }

    final startYear = int.parse(selectedStartYear!);
    final endYear = int.parse(selectedEndYear!);

    print("Seçilen yıllar: Başlangıç: $startYear, Bitiş: $endYear");

    // BarChartWidget ile iletişim kur ve yıl filtrelerini uygula
    widget.chartKey.currentState?.updateYearFilters(startYear, endYear);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Görüntülenecek istatistikler başlığı
          const Text(
            "Görüntülenecek İstatistikler",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Checkboxlarla tablo filtreleme (A ve B üst satır, C ve D alt satır)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isCheckedA,
                        onChanged: (value) {
                          setState(() {
                            isCheckedA = value!;
                            validateCheckboxes();
                          });
                        },
                      ),
                      const Text("Mutluluk Tablosu"),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isCheckedB,
                        onChanged: (value) {
                          setState(() {
                            isCheckedB = value!;
                            validateCheckboxes();
                          });
                        },
                      ),
                      const Text("Güvenlik Tablosu",softWrap: true,),

                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isCheckedC,
                        onChanged: (value) {
                          setState(() {
                            isCheckedC = value!;
                            validateCheckboxes();
                          });
                        },
                      ),
                      const Text("Kazançtan Memnuniyet"),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isCheckedD,
                        onChanged: (value) {
                          setState(() {
                            isCheckedD = value!;
                            validateCheckboxes();
                          });
                        },
                      ),
                      const Text("Refah Seviyesi"),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),

          // İstatistikler için uygula butonu
          Center(
            child: ElevatedButton(
              onPressed: applyStatisticsFilters,
              child: const Text("İstatistikleri Uygula"),
            ),
          ),

          const Divider(), // Görsel ayrım
          const SizedBox(height: 8),

          // Yıllarına filtrele başlığı
          const Text(
            "Yıllarına Filtrele",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Yıl filtreleme (Başlangıç ve Bitiş Yıllarını Yan Yana)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Başlangıç Yılı",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: selectedStartYear,
                    items: years
                        .map((year) =>
                            DropdownMenuItem(value: year, child: Text(year)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedStartYear = value;
                      });
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Bitiş Yılı",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: selectedEndYear,
                    items: years
                        .map((year) =>
                            DropdownMenuItem(value: year, child: Text(year)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedEndYear = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Yıl filtreleri için uygula butonu
          Center(
            child: ElevatedButton(
              onPressed: applyYearFilters,
              child: const Text("Yıl Filtrelerini Uygula"),
            ),
          ),
        ],
      ),
    );
  }
}

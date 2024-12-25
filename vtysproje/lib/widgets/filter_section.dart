import 'package:flutter/material.dart';

class FilterSection extends StatefulWidget {
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
    '2003', '2004', '2005', '2006', '2007',
    '2008', '2009', '2010', '2011', '2012',
    '2013', '2014', '2015', '2016', '2017',
    '2018', '2019', '2020', '2021', '2022', '2023',
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

  // İstatistikleri uygula butonu işlemi
  void applyStatisticsFilters() {
    final selectedFilters = [];
    if (isCheckedA) selectedFilters.add("A");
    if (isCheckedB) selectedFilters.add("B");
    if (isCheckedC) selectedFilters.add("C");
    if (isCheckedD) selectedFilters.add("D");

    print("Seçilen istatistik filtreleri: $selectedFilters");
    // Burada grafiğe seçilen istatistik filtrelerini ekleme işlemi yapılabilir.
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

    print("Seçilen yıllar: Başlangıç: $selectedStartYear, Bitiş: $selectedEndYear");
    // Burada grafiğe seçilen yıllar filtrelerini ekleme işlemi yapılabilir.
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
                      const Text("A"),
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
                      const Text("B"),
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
                      const Text("C"),
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
                      const Text("D"),
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
                  const Text("Başlangıç Yılı", style: TextStyle(fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: selectedStartYear,
                    items: years
                        .map((year) => DropdownMenuItem(value: year, child: Text(year)))
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
                  const Text("Bitiş Yılı", style: TextStyle(fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: selectedEndYear,
                    items: years
                        .map((year) => DropdownMenuItem(value: year, child: Text(year)))
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
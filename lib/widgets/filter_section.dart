import 'package:flutter/material.dart';
import 'package:LifeSatisfactionAnalysis/widgets/api_service.dart';
import 'package:LifeSatisfactionAnalysis/widgets/bar_chart_widget.dart';
class FilterSection extends StatefulWidget {

  final GlobalKey<BarChartWidgetState> chartKey;

  const FilterSection({required this.chartKey, Key? key}) : super(key: key);

  @override
  _FilterSectionState createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  // Seçilen başlangıç ve bitiş yılları
  String? selectedStartYear = '2003';
  String? selectedEndYear = '2023';
  String? selectedRelationYear='2003';
  String? textYear='2003';
  String? relationName='Güven ve Mutluluk';
  String? textRelation='Güven ve Mutluluk';
  String  firstText="";
  String  secondText="";

  // Checkbox kontrolü
  bool showSingleYear = false;
  String? selectedCheckbox;
  // Tablolar için checkbox durumları
  bool isChecked(String checkbox) => selectedCheckbox == checkbox;

  String relationMessage="";



  final List<String> relations=[
    'Kazanç Memnuniyet ve Mutluluk',
    'Refah Seviyesi ve Mutluluk',
    'Güven ve Mutluluk'
  ];

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

  void toggleCheckbox(String checkbox) {
    setState(() {
      if (selectedCheckbox == checkbox) {
        // Eğer tıklanan zaten seçiliyse seçimi kaldır
        selectedCheckbox = null;
      } else {
        // Tıklanan checkbox'ı seçili yap
        selectedCheckbox = checkbox;
      }
    });
  }

  void applyStatisticsFilters() {
    final selectedFilters = [];

    if (isChecked("A")) selectedFilters.add("A");
    if (isChecked("B")) selectedFilters.add("B");
    if (isChecked("C")) selectedFilters.add("C");
    if (isChecked("D")) selectedFilters.add("D");
    if (selectedFilters.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("En az bir seçenek seçilmelidir.")),
      );
      return;
    }

    // Seçilen filtreye göre BarChartWidget'ın veri kaynağını güncelle
    if (selectedFilters.contains("A")) {
      widget.chartKey.currentState?.updateFuture(ApiService.getMutlulukData(),"Mutluluk Tablosu");
      widget.chartKey.currentState?.tableData="Mutluluk Tablosu";
    } else if (selectedFilters.contains("B")) {
      widget.chartKey.currentState?.updateFuture(ApiService.getGuvenlikData(),"Güvenlik Tablosu");
      widget.chartKey.currentState?.tableData="Güvenlik Tablosu";
    } else if (selectedFilters.contains("C")) {
      widget.chartKey.currentState?.updateFuture(ApiService.getKazancData(),"Kazançtan Memnuniyet");
      widget.chartKey.currentState?.tableData="Kazançtan Memnuniyet Tablosu";
    }
    else if(selectedFilters.contains("D"))
    {
      widget.chartKey.currentState?.updateFuture(ApiService.getRefahData(),"Refah Seviyesi");
      widget.chartKey.currentState?.tableData="Refah Seviyesi Tablosu";
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

  void applyRelations() async{
    setState(() {
      textYear = selectedRelationYear;
      textRelation=relationName;
    });
    final intYear=int.parse(textYear!);
    final data;
    final filteredData;
    switch(relationName){
      case 'Güven ve Mutluluk':
        data = await ApiService.getGuvenVeMutlulukData();
        filteredData = data.firstWhere(
              (element) => element['yil'] == intYear,
          orElse: () => null,
        );
        if (filteredData != null) {
          setState(() {
            firstText = "Çok Güvenli oranı ile Çok mutlu oranı arasında %${filteredData['cok_guvenli_cok_mutlu']} oranında ilişki tespit edilmiştir.";
            secondText="Aynı yıl, Güvensiz ile Mutsuz oranı arasında %${filteredData['guvensiz_mutsuz']} oranında ilişki tespit edilmiştir.";
          });
        } else {
            firstText = "Seçilen yıl için veri bulunamadı.";
            secondText = "Seçilen yıl için veri bulunamadı.";
        }
        break;
      case 'Kazanç Memnuniyet ve Mutluluk':
        final data = await ApiService.getKazancVeMutlulukData();
        filteredData = data.firstWhere(
              (element) => element['yil'] == intYear,
          orElse: () => null,
        );
        if (filteredData != null) {
          setState(() {
            firstText = "Çok Memnun oranı ile Çok mutlu oranı arasında %${filteredData['cok_memnun_cok_mutlu']} oranında ilişki tespit edilmiştir.";
            secondText="Aynı yıl, Memnun Değil oranı ile Mutsuz oranı arasında %${filteredData['memnun_degil_mutsuz']} oranında ilişki tespit edilmiştir.";
          });
        } else {
          firstText = "Seçilen yıl için veri bulunamadı.";
          secondText = "Seçilen yıl için veri bulunamadı.";
        }
        break;
      case 'Refah Seviyesi ve Mutluluk':
        final data = await ApiService.getRefahVeMutlulukData();
        filteredData = data.firstWhere(
              (element) => element['yil'] == intYear,
          orElse: () => null,
        );
        if (filteredData != null) {
          setState(() {
            firstText = "Yüksek Refah Seviyesi oranı ile Çok mutlu oranı arasında %${filteredData['yuksek_cok_mutlu']} oranında ilişki tespit edilmiştir.";
            secondText="Aynı yıl, En düşük Refah Seviyesi oranı ile Mutsuz oranı arasında %${filteredData['en_dusuk_mutsuz']} oranında ilişki tespit edilmiştir.";
          });
        } else {
          firstText = "Seçilen yıl için veri bulunamadı.";
          secondText = "Seçilen yıl için veri bulunamadı.";
        }
        break;
    }
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
                        value: isChecked("A"),
                        onChanged: (value) {
                          toggleCheckbox("A");
                          /*setState(() {
                            isCheckedA = value!;
                            validateCheckboxes();
                          });*/
                        },
                      ),
                      const Text("Mutluluk Tablosu"),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked("B"),
                        onChanged: (value) {
                          toggleCheckbox("B");
                          /*setState(() {
                            isCheckedB = value!;
                            validateCheckboxes();
                          });*/
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
                        value: isChecked("C"),
                        onChanged: (value) {
                          toggleCheckbox("C");
                          /*setState(() {
                            isCheckedC = value!;
                            validateCheckboxes();
                          });*/
                        },
                      ),
                      const Text("Kazançtan Memnuniyet"),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked("D"),
                        onChanged: (value) {
                          toggleCheckbox("D");
                          /*setState(() {
                            isCheckedD = value!;
                            validateCheckboxes();
                          });*/
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
            "Yılları Filtrele",
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
          const Divider(), // Görsel ayrım
          const SizedBox(height: 8),

          const Text(
            "İlişki Görüntüle",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // İlişki filtreleme (Başlangıç ve Bitiş Yıllarını Yan Yana)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Yıl",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: selectedRelationYear,
                    items: years
                        .map((year) =>
                        DropdownMenuItem(value: year, child: Text(year)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedRelationYear = value;
                      });
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("İlişkiler",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: relationName,
                    items: relations
                        .map((relations) =>
                        DropdownMenuItem(value: relations, child: Text(relations)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        relationName = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "$textYear Yılında $relationName İlişkisi",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(
            firstText,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Text(
            secondText,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Center(
            child: ElevatedButton(
              onPressed: applyRelations,
              child: const Text("İlişki Görüntüle"),
            ),
          ),
          const Divider(), // Görsel ayrım
          const Text(
            "Güvenlik Refah ve Kazancın Mutluluğa Etkileri",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("1. Mutluluk → Kazanç: %417.83\n"
          "2. Güvenlik → Kazanç: %381.51\n"
          "3. Refah → Kazanç: %272.06\n"
          "4. Mutluluk → Refah: %157.23\n"
          "5. Güvenlik → Refah: %143.89\n"
          "6. Mutluluk → Güvenlik: %112.39\n"
          "7. Güvenlik → Mutluluk: %97.52\n"
          "8. Refah → Mutluluk: %72.70\n"
          "9. Refah → Güvenlik: %72.68\n"
          "10. Kazanç → Refah: %39.96\n"
          "11. Kazanç → Güvenlik: %28.90\n"
          "12. Kazanç → Mutluluk: %27.42\n",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/relation.jpg',
                    height: 163,
                  ),
                  SizedBox(width: 8),
                ],
              ),
            ],
          ),
          const Divider(), // Görsel ayrım
          const Text(
            "Araştırmanın Detayları:",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          const Text(
               "Bu çalışma, 25-34 yaş arası bireylerin yaşam memnuniyeti üzerine yapılan bir analizdir.\n"
                   "Veriler, https://biruni.tuik.gov.tr/medas/?locale=tr sitesinden alınmıştır.\n"
                  "Analiz; Genel Mutluluk Düzeyi (%), "
                  "İşten Elde Edilen Kazançtan Duyulan Memnuniyet Düzeyi (%),"
                  " Yaşanılan Çevrede Bireyin Kendini Güvende Hissetmesi (%) "
                  "ve Algılanan Refah Düzeyi (%) verileri üzerinde işlemler yapılarak oluşturulmuştur.",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

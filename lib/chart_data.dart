class ChartData {
  ChartData(this.year, this.cokMutlu, this.mutlu, this.orta, this.mutsuz, this.cokMutsuz);

  final String year; // Yıl
  final double? cokMutlu; // Çok Mutlu veya Çok Güvenli
  final double? mutlu;    // Mutlu veya Güvenli
  final double? orta;     // Orta
  final double? mutsuz;   // Mutsuz veya Güvensiz
  final double? cokMutsuz; // Çok Mutsuz veya Çok Güvensiz
}

class ChartData {
  ChartData({
    required this.year,
    this.cokMutlu,
    this.mutlu,
    this.orta,
    this.mutsuz,
    this.cokMutsuz,
    this.cokGuvenli,
    this.guvenli,
    this.guvensiz,
    this.cokGuvensiz,
    this.cokMemnun,
    this.memnun,
    this.memnunDegil,
    this.hicMemnunDegil,
    this.kazanciYok,
  });

  final String year;
  final double? cokMutlu;
  final double? mutlu;
  final double? orta;
  final double? mutsuz;
  final double? cokMutsuz;
  final double? cokGuvenli;
  final double? guvenli;
  final double? guvensiz;
  final double? cokGuvensiz;
  final double? cokMemnun;
  final double? memnun;
  final double? memnunDegil;
  final double? hicMemnunDegil;
  final double? kazanciYok;
}

import 'package:flutter/widgets.dart';
import 'package:cinta_film/domain/entities/aliranFilm.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

String fromatDurasi(int durasi) {
  final int jam = durasi ~/ 60;
  final int menit = durasi % 60;
  final String durFi = 'Durasi Film';

  if (jam > 0) {
    return '$durFi ${jam} Jam ${menit} Menit';
  } else {
    return '$durFi Film ${menit} Menit';
  }
}

String tampilkanDurasiListFilm(List<int> durasi) {
  return durasi.map((durasi) => fromatDurasi(durasi)).join(", ");
}

String aliranFilm(List<ClassAliranFilm> aliranFilm) {
  String tempHasilAliranFilm = '';

  for (var aliran in aliranFilm) {
    tempHasilAliranFilm += aliran.name + ', ';
  }

  if (tempHasilAliranFilm.isEmpty) {
    return tempHasilAliranFilm;
  }

  return tempHasilAliranFilm.substring(0, tempHasilAliranFilm.length - 2);
}

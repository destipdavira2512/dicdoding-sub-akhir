import 'package:equatable/equatable.dart';

class ClassAliranFilm extends Equatable {
  ClassAliranFilm({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];
}

import 'package:dartz/dartz.dart';
import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/data/lib_server_fail.dart';
import 'package:cinta_film/domain/entities/movie_detail.dart';


class ClassDaftarTontonFilm {
  final RepositoryFilm _repository;
  ClassDaftarTontonFilm(this._repository);
  Future<Either<Failure, List<Film>>> execute() {
    return _repository.ambilDaftarTontonFilm();
  }
}

class AmbilDataDetailFilm {
  final RepositoryFilm repository;
  AmbilDataDetailFilm(this.repository);
  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}

class ClassFilmRatingTerbaik {
  final RepositoryFilm repository;
  ClassFilmRatingTerbaik(this.repository);
  Future<Either<Failure, List<Film>>> execute() {
    return repository.ambilFilmRatingTerbaik();
  }
}

class AmbilDataRekomendasiFilm {
  final RepositoryFilm repository;
  AmbilDataRekomendasiFilm(this.repository);
  Future<Either<Failure, List<Film>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}

class ClassFilmTerPopuler {
  final RepositoryFilm repository;
  ClassFilmTerPopuler(this.repository);
  Future<Either<Failure, List<Film>>> execute() {
    return repository.ambilDataFilmTerPopuler();
  }
}

class ClasFilmTayangSaatIni {
  final RepositoryFilm repository;
  ClasFilmTayangSaatIni(this.repository);
  Future<Either<Failure, List<Film>>> execute() {
    return repository.filmTayangSaatIni();
  }
}

class ClassStatusDaftarTonton {
  final RepositoryFilm repository;
  ClassStatusDaftarTonton(this.repository);
  Future<bool> execute(int id) async {
    return repository.isAddedTowatchlist(id);
  }
}

class ClassCariFilm {
  final RepositoryFilm repository;
  ClassCariFilm(this.repository);
  Future<Either<Failure, List<Film>>> execute(String query) {
    return repository.cariFilm(query);
  }
}

class ClassSimpanDaftarTonton {
  final RepositoryFilm repository;
  ClassSimpanDaftarTonton(this.repository);
  Future<Either<Failure, String>> execute(MovieDetail film) {
    return repository.daftarTonton(film);
  }
}

class ClassHapusDaftarTonton {
  final RepositoryFilm repository;
  ClassHapusDaftarTonton(this.repository);
  Future<Either<Failure, String>> execute(MovieDetail film) {
    return repository.removewatchlist(film);
  }
}

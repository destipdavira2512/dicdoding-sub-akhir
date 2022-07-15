import 'package:dartz/dartz.dart';
import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:cinta_film/data/lib_server_fail.dart';


class GetserialTvSaatIniDiPutarls {
  final TvlsRepository repository;
  GetserialTvSaatIniDiPutarls(this.repository);
  Future<Either<Failure, List<Tvls>>> execute() {
    return repository.getserialTvSaatIniDiPutar();
  }
}

class GetPopularTvls {
  final TvlsRepository repository;
  GetPopularTvls(this.repository);
  Future<Either<Failure, List<Tvls>>> execute() {
    return repository.getPopularTv();
  }
}

class GetTopRatedTvls {
  final TvlsRepository repository;

  GetTopRatedTvls(this.repository);

  Future<Either<Failure, List<Tvls>>> execute() {
    return repository.getTopRatedTv();
  }
}

class GetTvlsDetail {
  final TvlsRepository repository;

  GetTvlsDetail(this.repository);

  Future<Either<Failure, TvlsDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}

class GetTvlsRecommendations {
  final TvlsRepository repository;

  GetTvlsRecommendations(this.repository);

  Future<Either<Failure, List<Tvls>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}

class ClassStatusDaftarTontonTvls {
  final TvlsRepository repository;

  ClassStatusDaftarTontonTvls(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedTowatchlistTv(id);
  }
}

class GetwatchlistTvls {
  final TvlsRepository _repository;

  GetwatchlistTvls(this._repository);

  Future<Either<Failure, List<Tvls>>> execute() {
    return _repository.getwatchlistTv();
  }
}

class ClassHapusDaftarTontonTvls {
  final TvlsRepository repository;

  ClassHapusDaftarTontonTvls(this.repository);

  Future<Either<Failure, String>> execute(TvlsDetail tv) {
    return repository.removewatchlistTv(tv);
  }
}

class ClassSimpanDaftarTontonTvls {
  final TvlsRepository repository;

  ClassSimpanDaftarTontonTvls(this.repository);

  Future<Either<Failure, String>> execute(TvlsDetail tv) {
    return repository.savewatchlistTv(tv);
  }
}

class SearchTvls {
  final TvlsRepository repository;

  SearchTvls(this.repository);

  Future<Either<Failure, List<Tvls>>> execute(String query) {
    return repository.searchTv(query);
  }
}

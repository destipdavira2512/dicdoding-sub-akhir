import 'package:dartz/dartz.dart';
import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/domain/entities/movie_detail.dart';
import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';
import 'package:cinta_film/data/datasources/tvls/tvls_local_data_source.dart';
import 'package:cinta_film/data/datasources/tvls/tvls_remote_data_source.dart';
import 'package:cinta_film/data/models/tvls/tvls_table.dart';
import 'package:cinta_film/data/datasources/film/movie_local_data_source.dart';
import 'package:cinta_film/data/datasources/film/movie_remote_data_source.dart';
import 'package:cinta_film/data/models/movie_table.dart';

const String pesanNwe = 'Failed to connect to the network';
const String pesanCer = 'Certificate unvalid';

abstract class RepositoryFilm {
  Future<Either<Failure, List<Film>>> filmTayangSaatIni();
  Future<Either<Failure, List<Film>>> ambilDataFilmTerPopuler();
  Future<Either<Failure, List<Film>>> ambilFilmRatingTerbaik();
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id);
  Future<Either<Failure, List<Film>>> getMovieRecommendations(int id);
  Future<Either<Failure, List<Film>>> cariFilm(String query);
  Future<Either<Failure, String>> daftarTonton(MovieDetail film);
  Future<Either<Failure, String>> removewatchlist(MovieDetail film);
  Future<bool> isAddedTowatchlist(int id);
  Future<Either<Failure, List<Film>>> ambilDaftarTontonFilm();
}

abstract class TvlsRepository{
  Future<Either<Failure, List<Tvls>>> getserialTvSaatIniDiPutar();
  Future<Either<Failure, List<Tvls>>> getPopularTv();
  Future<Either<Failure, List<Tvls>>> getTopRatedTv();
  Future<Either<Failure, TvlsDetail>> getTvDetail(int id);
  Future<Either<Failure, List<Tvls>>> getTvRecommendations(int id);
  Future<Either<Failure, List<Tvls>>> searchTv(String query);
  Future<Either<Failure, String>> savewatchlistTv(TvlsDetail tv);
  Future<Either<Failure, String>> removewatchlistTv(TvlsDetail tv);
  Future<bool> isAddedTowatchlistTv(int id);
  Future<Either<Failure, List<Tvls>>> getwatchlistTv();
}

class DatabaseException implements Exception {
  final String message;
  DatabaseException(this.message);
}

abstract class Failure extends Equatable {
  final String message;
  Failure(this.message);
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}

class ConnectionFailure extends Failure {
  ConnectionFailure(String message) : super(message);
}

class DatabaseFailure extends Failure {
  DatabaseFailure(String message) : super(message);
}

class SslFailure extends Failure {
  SslFailure(String message) : super(message);
}

class ServerException implements Exception {}


class RepositoryFilmImpl implements RepositoryFilm {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  RepositoryFilmImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  
  Future<Either<Failure, List<Film>>> filmTayangSaatIni() async {
    try {
      final result = await remoteDataSource.filmTayangSaatIni();
      return Right(result.map((model) => model.toEntity()).toList());
    } on TlsException {
      return Left(SslFailure(pesanCer));
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure(pesanNwe));
    }
  }

  
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id) async {
    try {
      final result = await remoteDataSource.getMovieDetail(id);
      return Right(result.toEntity());
    } on TlsException {
      return Left(SslFailure(pesanCer));
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure(pesanNwe));
    }
  }

  
  Future<Either<Failure, List<Film>>> getMovieRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getMovieRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on TlsException {
      return Left(SslFailure(pesanCer));
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure(pesanNwe));
    }
  }

  
  Future<Either<Failure, List<Film>>> ambilDataFilmTerPopuler() async {
    try {
      final result = await remoteDataSource.ambilDataFilmTerPopuler();
      return Right(result.map((model) => model.toEntity()).toList());
    } on TlsException {
      return Left(SslFailure(pesanCer));
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure(pesanNwe));
    }
  }

  
  Future<Either<Failure, List<Film>>> ambilFilmRatingTerbaik() async {
    try {
      final result = await remoteDataSource.ambilFilmRatingTerbaik();
      return Right(result.map((model) => model.toEntity()).toList());
    } on TlsException {
      return Left(SslFailure(pesanCer));
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure(pesanNwe));
    }
  }

  
  Future<Either<Failure, List<Film>>> cariFilm(String query) async {
    try {
      final result = await remoteDataSource.cariFilm(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on TlsException {
      return Left(SslFailure(pesanCer));
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure(pesanNwe));
    }
  }

  
  Future<Either<Failure, String>> daftarTonton(MovieDetail film) async {
    try {
      final result =
          await localDataSource.insertwatchlist(MovieTable.fromEntity(film));
      return Right(result);
    } on TlsException {
      return Left(SslFailure(pesanCer));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  
  Future<Either<Failure, String>> removewatchlist(MovieDetail film) async {
    try {
      final result =
          await localDataSource.removewatchlist(MovieTable.fromEntity(film));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  
  Future<bool> isAddedTowatchlist(int id) async {
    final result = await localDataSource.getMovieById(id);
    return result != null;
  }

  
  Future<Either<Failure, List<Film>>> ambilDaftarTontonFilm() async {
    final result = await localDataSource.ambilDaftarTontonFilm();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}

class TvlsRepositoryImpl implements TvlsRepository {
  final TvlsRemoteDataSource remoteDataSource;
  final TvlsLocalDataSource localDataSource;

  TvlsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  
  Future<Either<Failure, List<Tvls>>> getserialTvSaatIniDiPutar() async {
    try {
      final result = await remoteDataSource.getserialTvSaatIniDiPutar();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure(pesanNwe));
    }
  }

  
  Future<Either<Failure, TvlsDetail>> getTvDetail(int id) async {
    try {
      final result = await remoteDataSource.getTvDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure(pesanNwe));
    }
  }

  
  Future<Either<Failure, List<Tvls>>> getTvRecommendations(int id) async {
    try {
      final result = await remoteDataSource.getTvRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure(pesanNwe));
    }
  }

  
  Future<Either<Failure, List<Tvls>>> getPopularTv() async {
    try {
      final result = await remoteDataSource.getPopularTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure(pesanNwe));
    }
  }

  
  Future<Either<Failure, List<Tvls>>> getTopRatedTv() async {
    try {
      final result = await remoteDataSource.getTopRatedTv();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure(pesanNwe));
    }
  }

  
  Future<Either<Failure, List<Tvls>>> searchTv(String query) async {
    try {
      final result = await remoteDataSource.searchTv(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure(pesanNwe));
    }
  }

  
  Future<Either<Failure, String>> savewatchlistTv(TvlsDetail tv) async {
    try {
      final result =
          await localDataSource.insertwatchlistTv(TvlsTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  
  Future<Either<Failure, String>> removewatchlistTv(TvlsDetail tv) async {
    try {
      final result =
          await localDataSource.removewatchlistTv(TvlsTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  
  Future<bool> isAddedTowatchlistTv(int id) async {
    final result = await localDataSource.getTvById(id);
    return result != null;
  }

  
  Future<Either<Failure, List<Tvls>>> getwatchlistTv() async {
    final result = await localDataSource.getwatchlistTv();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}

import 'package:cinta_film/data/lib_database.dart';
import 'package:cinta_film/data/datasources/film/movie_remote_data_source.dart';
import 'package:cinta_film/data/datasources/film/movie_local_data_source.dart';
import 'package:cinta_film/data/lib_server_fail.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:cinta_film/presentasi/bloc/film_bloc.dart';
import 'package:cinta_film/domain/get_data_film.dart';

@GenerateMocks([
  RepositoryFilm,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  DatabaseHelper,
  ClassDaftarTontonFilm,
  AmbilDataDetailFilm,
  ClassFilmRatingTerbaik,
  AmbilDataRekomendasiFilm,
  ClassFilmTerPopuler,
  ClasFilmTayangSaatIni,
  ClassStatusDaftarTonton,
  ClassCariFilm,
  ClassSimpanDaftarTonton,
  ClassHapusDaftarTonton,
  MoviePopularBloc,
  MovieNowPlayingBloc,
  MovieRecommendationBloc,
  MovieTopRatedBloc,
  MovieSearchBloc,
  DetailFilmBloc,
  DaftarTontonFilmBloc
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

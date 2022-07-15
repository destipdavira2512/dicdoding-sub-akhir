import 'package:cinta_film/data/lib_database.dart';
import 'package:cinta_film/data/datasources/film/movie_local_data_source.dart';
import 'package:cinta_film/data/datasources/film/movie_remote_data_source.dart';
import 'package:cinta_film/data/datasources/tvls/tvls_local_data_source.dart';
import 'package:cinta_film/data/datasources/tvls/tvls_remote_data_source.dart';
import 'package:cinta_film/data/lib_server_fail.dart';
import 'package:cinta_film/domain/get_data_film.dart';
import 'package:cinta_film/domain/get_data_tv.dart';
import 'package:cinta_film/presentasi/bloc/film_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:cinta_film/data/ssl_pinning.dart';
import 'package:cinta_film/presentasi/bloc/tv_bloc.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(() => 
    DetailFilmBloc(
      getMovieDetail: locator(),
    )
  );
  locator.registerFactory(() =>
    MovieNowPlayingBloc(
      locator()
    ),
  );
  locator.registerFactory(() => 
    MoviePopularBloc(
      locator()
    ),
  );
  locator.registerFactory(() => 
    MovieRecommendationBloc(
      getMovieRecommendations: locator(),
    )
  );
  locator.registerFactory(() => 
    MovieSearchBloc(
      searchMovies: locator(),
    )
  );
  locator.registerFactory(() => 
    MovieTopRatedBloc(
      locator()
    ),
  );
  locator.registerFactory(() => 
    DaftarTontonFilmBloc(
      getWatchlistMovies: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator()
  ));
  locator.registerFactory(()                              => TvseriesDetailBloc(locator()));
  locator.registerFactory(()                              => OnTheAirTvseriesBloc(locator()));
  locator.registerFactory(()                              => PopularTvseriesBloc(locator()));
  locator.registerFactory(()                              => TvseriesRecommendationsBloc(locator()));
  locator.registerFactory(()                              => TvseriesSearchBloc(locator()));
  locator.registerFactory(()                              => TopRatedTvseriesBloc(locator()));
  locator.registerFactory(()                              => WatchlistTvseriesBloc(locator(),locator(),locator(),locator()));
  locator.registerLazySingleton<RepositoryFilm>(()        => RepositoryFilmImpl(remoteDataSource: locator(),localDataSource: locator()));
  locator.registerLazySingleton<TvlsRepository>(()        => TvlsRepositoryImpl(remoteDataSource: locator(),localDataSource: locator()));
  locator.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(()  => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvlsRemoteDataSource>(()  => TvlsRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvlsLocalDataSource>(()   => TvlsLocalDataSourceImpl(databaseHelpertvls: locator()));
  locator.registerLazySingleton<DatabaseHelper>(()        => DatabaseHelper());
  locator.registerLazySingleton<DatabaseHelperTvls>(()    => DatabaseHelperTvls());
  locator.registerLazySingleton(() => ClassSSLPinning.client);
  locator.registerLazySingleton(() => ClasFilmTayangSaatIni(locator()));
  locator.registerLazySingleton(() => ClassFilmTerPopuler(locator()));
  locator.registerLazySingleton(() => ClassFilmRatingTerbaik(locator()));
  locator.registerLazySingleton(() => AmbilDataDetailFilm(locator()));
  locator.registerLazySingleton(() => AmbilDataRekomendasiFilm(locator()));
  locator.registerLazySingleton(() => ClassCariFilm(locator()));
  locator.registerLazySingleton(() => ClassStatusDaftarTonton(locator()));
  locator.registerLazySingleton(() => ClassSimpanDaftarTonton(locator()));
  locator.registerLazySingleton(() => ClassHapusDaftarTonton(locator()));
  locator.registerLazySingleton(() => ClassDaftarTontonFilm(locator()));
  locator.registerLazySingleton(() => GetserialTvSaatIniDiPutarls(locator()));
  locator.registerLazySingleton(() => GetPopularTvls(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvls(locator()));
  locator.registerLazySingleton(() => GetTvlsDetail(locator()));
  locator.registerLazySingleton(() => GetTvlsRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvls(locator()));
  locator.registerLazySingleton(() => ClassStatusDaftarTontonTvls(locator()));
  locator.registerLazySingleton(() => ClassSimpanDaftarTontonTvls(locator()));
  locator.registerLazySingleton(() => ClassHapusDaftarTontonTvls(locator()));
  locator.registerLazySingleton(() => GetwatchlistTvls(locator()));


}

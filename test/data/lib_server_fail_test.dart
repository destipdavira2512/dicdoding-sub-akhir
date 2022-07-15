import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:cinta_film/data/models/genre_model.dart';
import 'package:cinta_film/data/models/tvls/tvls_detail_model.dart';
import 'package:cinta_film/data/models/tvls/tvls_model.dart';
import 'package:cinta_film/data/lib_server_fail.dart';
import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cinta_film/data/models/movie_detail_model.dart';
import 'package:cinta_film/data/models/movie_model.dart';
import 'package:cinta_film/domain/entities/film.dart';

import '../dummy_data/dummy_objects_tvls.dart';
import '../dummy_data/dummy_objects.dart';
import '../helpers/test_helper_tvls.mocks.dart';
import '../helpers/test_helper.mocks.dart';

void main() {
  late TvlsRepositoryImpl repository;
  late MockTvlsRemoteDataSource mockRemoteDataSource;
  late MockTvlsLocalDataSource mockLocalDataSource;
  late RepositoryFilmImpl repositoryFilm;
  late MockMovieRemoteDataSource mockRemoteDataFilm;
  late MockMovieLocalDataSource mockLocalDataSourceFilm;
  

  setUp(() {
    mockRemoteDataSource = MockTvlsRemoteDataSource();
    mockLocalDataSource = MockTvlsLocalDataSource();
    repository = TvlsRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
    mockRemoteDataFilm = MockMovieRemoteDataSource();
    mockLocalDataSourceFilm = MockMovieLocalDataSource();
    repositoryFilm = RepositoryFilmImpl(
      remoteDataSource: mockRemoteDataFilm,
      localDataSource: mockLocalDataSourceFilm,
    );
  });
  
  final tTvModel = TvlsModel(
    backdropPath: '/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg',
    genreIds: [10765, 10759, 18],
    id: 1399,
    originalName: 'Game of Thrones',
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    popularity: 29.780826,
    posterPath: '/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg',
    firstAirDate: '2011-04-17',
    name: 'Game of Thrones',
    voteAverage: 7.91,
    voteCount: 1172,
  );

  final tTv = Tvls(
    backdropPath: '/mUkuc2wyV9dHLG0D0Loaw5pO2s8.jpg',
    genreIds: [10765, 10759, 18],
    id: 1399,
    originalName: 'Game of Thrones',
    overview: "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    popularity: 29.780826,
    posterPath: '/jIhL6mlT7AblhbHJgEoiBIOUVl1.jpg',
    firstAirDate: '2011-04-17',
    name: 'Game of Thrones',
    voteAverage: 7.91,
    voteCount: 1172,
  );

  final tMovieModel = MovieModel(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview: 'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovie = Film(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final tMovieModelList = <MovieModel>[tMovieModel];
  final tMovieList = <Film>[tMovie];
  final tTvModelList = <TvlsModel>[tTvModel];
  final tTvList = <Tvls>[tTv];

  group('Serial Tv Yang Sedang Tayang', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getserialTvSaatIniDiPutar())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getserialTvSaatIniDiPutar();
      // assert
      verify(mockRemoteDataSource.getserialTvSaatIniDiPutar());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getserialTvSaatIniDiPutar())
          .thenThrow(ServerException());
      // act
      final result = await repository.getserialTvSaatIniDiPutar();
      // assert
      verify(mockRemoteDataSource.getserialTvSaatIniDiPutar());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getserialTvSaatIniDiPutar())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getserialTvSaatIniDiPutar();
      // assert
      verify(mockRemoteDataSource.getserialTvSaatIniDiPutar());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Tv', () {
    test('should return Tv list when call to data source is success', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTv())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getPopularTv();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTv()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTv();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTv())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTv();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Serial Tv Ranting Tertinggi', () {
    test('should return Tv list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTv())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getTopRatedTv();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTv()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTv();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTv())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTv();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Tv Detail', () {
    final tId = 1;
    final tTvResponse = TvlsDetailResponse(
      backdropPath: 'backdropPath',
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      originalLanguage: 'en',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      firstAirDate: 'firstAirDate',
      status: 'Status',
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      tagline: 'Tagline',
      name: 'name',
      type: 'type',
      voteAverage: 1,
      voteCount: 1,
    );

    test(
        'should return Tv data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId))
          .thenAnswer((_) async => tTvResponse);
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(result, equals(Right(testTvDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Tv Recommendations', () {
    final tTvList = <TvlsModel>[];
    final tId = 1;

    test('should return data (tv list) when the call is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenAnswer((_) async => tTvList);
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Tv', () {
    final tQuery = 'game of thrones';

    test('should return tv list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTv(tQuery))
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.searchTv(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTv(tQuery)).thenThrow(ServerException());
      // act
      final result = await repository.searchTv(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTv(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTv(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist tv', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertwatchlistTv(testTvTable))
          .thenAnswer((_) async => 'Added to watchlist');
      // act
      final result = await repository.savewatchlistTv(testTvDetail);
      // assert
      expect(result, Right('Added to watchlist'));
    });

    test('should return Database Failure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertwatchlistTv(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.savewatchlistTv(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist tv', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removewatchlistTv(testTvTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removewatchlistTv(testTvDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return Database Failure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removewatchlistTv(testTvTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removewatchlistTv(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedTowatchlistTv(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tv', () {
    test('should return list of Tv', () async {
      // arrange
      when(mockLocalDataSource.getwatchlistTv())
          .thenAnswer((_) async => [testTvTable]);
      // act
      final result = await repository.getwatchlistTv();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testwatchlistTv]);
    });
  });

    group('Now Playing Film', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataFilm.filmTayangSaatIni())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repositoryFilm.filmTayangSaatIni();
      // assert
      verify(mockRemoteDataFilm.filmTayangSaatIni());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataFilm.filmTayangSaatIni())
          .thenThrow(ServerException());
      // act
      final result = await repositoryFilm.filmTayangSaatIni();
      // assert
      verify(mockRemoteDataFilm.filmTayangSaatIni());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataFilm.filmTayangSaatIni())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repositoryFilm.filmTayangSaatIni();
      // assert
      verify(mockRemoteDataFilm.filmTayangSaatIni());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Film', () {
    test('should return film list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataFilm.ambilDataFilmTerPopuler())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repositoryFilm.ambilDataFilmTerPopuler();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataFilm.ambilDataFilmTerPopuler())
          .thenThrow(ServerException());
      // act
      final result = await repositoryFilm.ambilDataFilmTerPopuler();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataFilm.ambilDataFilmTerPopuler())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repositoryFilm.ambilDataFilmTerPopuler();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Film', () {
    test('should return film list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataFilm.ambilFilmRatingTerbaik())
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repositoryFilm.ambilFilmRatingTerbaik();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataFilm.ambilFilmRatingTerbaik())
          .thenThrow(ServerException());
      // act
      final result = await repositoryFilm.ambilFilmRatingTerbaik();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataFilm.ambilFilmRatingTerbaik())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repositoryFilm.ambilFilmRatingTerbaik();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get film Detail', () {
    final tId = 1;
    final tMovieResponse = MovieDetailResponse(
      adult: false,
      backdropPath: 'backdropPath',
      budget: 100,
      genres: [GenreModel(id: 1, name: 'Action')],
      homepage: "https://google.com",
      id: 1,
      imdbId: 'imdb1',
      originalLanguage: 'en',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      revenue: 12000,
      runtime: 120,
      status: 'Status',
      tagline: 'Tagline',
      title: 'title',
      video: false,
      voteAverage: 1,
      voteCount: 1,
    );

    test(
        'should return film data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataFilm.getMovieDetail(tId))
          .thenAnswer((_) async => tMovieResponse);
      // act
      final result = await repositoryFilm.getMovieDetail(tId);
      // assert
      verify(mockRemoteDataFilm.getMovieDetail(tId));
      expect(result, equals(Right(testMovieDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataFilm.getMovieDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repositoryFilm.getMovieDetail(tId);
      // assert
      verify(mockRemoteDataFilm.getMovieDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataFilm.getMovieDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repositoryFilm.getMovieDetail(tId);
      // assert
      verify(mockRemoteDataFilm.getMovieDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get film Recommendations', () {
    final tMovieList = <MovieModel>[];
    final tId = 1;

    test('should return data (film list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataFilm.getMovieRecommendations(tId))
          .thenAnswer((_) async => tMovieList);
      // act
      final result = await repositoryFilm.getMovieRecommendations(tId);
      // assert
      verify(mockRemoteDataFilm.getMovieRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tMovieList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataFilm.getMovieRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repositoryFilm.getMovieRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataFilm.getMovieRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataFilm.getMovieRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repositoryFilm.getMovieRecommendations(tId);
      // assert
      verify(mockRemoteDataFilm.getMovieRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Film', () {
    final tQuery = 'spiderman';

    test('should return film list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataFilm.cariFilm(tQuery))
          .thenAnswer((_) async => tMovieModelList);
      // act
      final result = await repositoryFilm.cariFilm(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tMovieList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataFilm.cariFilm(tQuery)).thenThrow(ServerException());
      // act
      final result = await repositoryFilm.cariFilm(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataFilm.cariFilm(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repositoryFilm.cariFilm(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSourceFilm.insertwatchlist(testMovieTable))
          .thenAnswer((_) async => 'Added to watchlist');
      // act
      final result = await repositoryFilm.daftarTonton(testMovieDetail);
      // assert
      expect(result, Right('Added to watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSourceFilm.insertwatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repositoryFilm.daftarTonton(testMovieDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSourceFilm.removewatchlist(testMovieTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repositoryFilm.removewatchlist(testMovieDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSourceFilm.removewatchlist(testMovieTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repositoryFilm.removewatchlist(testMovieDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSourceFilm.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repositoryFilm.isAddedTowatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist Film', () {
    test('should return list of Film', () async {
      // arrange
      when(mockLocalDataSourceFilm.ambilDaftarTontonFilm())
          .thenAnswer((_) async => [testMovieTable]);
      // act
      final result = await repositoryFilm.ambilDaftarTontonFilm();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testwatchlistMovie]);
    });
  });

}

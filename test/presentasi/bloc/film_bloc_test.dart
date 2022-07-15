import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cinta_film/presentasi/bloc/film_bloc.dart';
import 'package:cinta_film/data/lib_server_fail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockClassDaftarTontonFilm mockGetWatchlistMovies;
  late MockClassStatusDaftarTonton mockGetWatchListStatus;
  late MockClassSimpanDaftarTonton mockSaveWatchlist;
  late MockClassHapusDaftarTonton mockRemoveWatchlist;
  late MockClassFilmRatingTerbaik mockGetTopRatedMovies;
  late MockClassCariFilm mockSearchMovies;
  late MockClassFilmTerPopuler mockGetPopularMovies;
  late MockAmbilDataRekomendasiFilm mockGetMovieRecommendation;
  late MockAmbilDataDetailFilm mockAmbilDataDetailFilm;
  late MockClasFilmTayangSaatIni mockGetNowPlayingMovies;

  late MovieRecommendationBloc movieRecommendationBloc;
  late MovieSearchBloc movieSearchBloc;
  late MovieTopRatedBloc movieTopRatedBloc;
  late DaftarTontonFilmBloc movieWatchlistBloc;
  late MovieNowPlayingBloc movieNowPlayingBloc;
  late DetailFilmBloc movieDetailBloc;
  late MoviePopularBloc moviePopularBloc;

  setUp(() {
    
    mockGetWatchlistMovies      = MockClassDaftarTontonFilm();
    mockGetWatchListStatus      = MockClassStatusDaftarTonton();
    mockSaveWatchlist           = MockClassSimpanDaftarTonton();
    mockRemoveWatchlist         = MockClassHapusDaftarTonton();
    mockGetTopRatedMovies       = MockClassFilmRatingTerbaik();
    mockGetPopularMovies        = MockClassFilmTerPopuler();
    mockSearchMovies            = MockClassCariFilm();
    mockGetNowPlayingMovies     = MockClasFilmTayangSaatIni();
    mockAmbilDataDetailFilm     = MockAmbilDataDetailFilm();
    mockGetMovieRecommendation  = MockAmbilDataRekomendasiFilm();
    
    movieTopRatedBloc           = MovieTopRatedBloc(mockGetTopRatedMovies);
    moviePopularBloc            = MoviePopularBloc(mockGetPopularMovies);
    movieDetailBloc             = DetailFilmBloc(getMovieDetail: mockAmbilDataDetailFilm);
    movieNowPlayingBloc         = MovieNowPlayingBloc(mockGetNowPlayingMovies);
    movieWatchlistBloc          = DaftarTontonFilmBloc(
      getWatchlistMovies  : mockGetWatchlistMovies,
      getWatchListStatus  : mockGetWatchListStatus,
      saveWatchlist       : mockSaveWatchlist,
      removeWatchlist     : mockRemoveWatchlist,
    );
    movieSearchBloc             = MovieSearchBloc(
      searchMovies : mockSearchMovies,
    );
    movieRecommendationBloc     = MovieRecommendationBloc(
      getMovieRecommendations: mockGetMovieRecommendation,
    );
  });

  const revId = 1;
  const query = "originalTitle";

  test("DaftarTontonFilmBloc must be initial state should be empty", () {
    expect(movieWatchlistBloc.state, MovieWatchlistEmpty());
  });

  test("DetailFilmBloc must be initial state should be empty", () {
    expect(movieDetailBloc.state, DataDetailFilmKosong());
  });

  test("MovieTopRatedBloc must be initial state should be empty", () {
    expect(movieTopRatedBloc.state, MovieTopRatedEmpty());
  });

  test("MovieSearchBloc must be initial state should be empty", () {
    expect(movieSearchBloc.state, MovieSearchEmpty());
  });

  test("MovieRecommendationBloc must be initial state should be empty", () {
    expect(movieRecommendationBloc.state, MovieRecommendationEmpty());
});
  
  test("MoviePopularBloc must be initial state should be empty", () {
    expect(moviePopularBloc.state, MoviePopularEmpty());
  });

  test("MovieNowPlayingBloc must be initial state should be empty", () {
    expect(movieNowPlayingBloc.state, MovieNowPlayingEmpty());
  });

  blocTest<DaftarTontonFilmBloc, StateDaftarTontonFilm>(
    'DaftarTontonFilmBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));

      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(GetListEvent()),
    expect: () =>
        [MovieWatchlistLoading(), MovieWatchlistLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<DaftarTontonFilmBloc, StateDaftarTontonFilm>(
    'DaftarTontonFilmBloc must be emit [Loading, Error] when get watchlist is unsuccessful',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure("Can't get data")));

      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(GetListEvent()),
    expect: () =>
        [MovieWatchlistLoading(), const MovieWatchlistError("Can't get data")],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<DaftarTontonFilmBloc, StateDaftarTontonFilm>(
    'DaftarTontonFilmBloc must emit [Loaded] when get status movie watchlist is successful',
    build: () {
      when(mockGetWatchListStatus.execute(revId)).thenAnswer((_) async => true);

      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(const GetStatusMovieEvent(revId)),
    expect: () => [const MovieWatchlistStatusLoaded(true)],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(revId));
    },
  );

  blocTest<DaftarTontonFilmBloc, StateDaftarTontonFilm>(
    'DaftarTontonFilmBloc must be emit [success] when add movie item to watchlist is successful',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right("Success"));

      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(AddItemMovieEvent(testMovieDetail)),
    expect: () => [const MovieWatchlistSuccess("Success")],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<DaftarTontonFilmBloc, StateDaftarTontonFilm>(
    'DaftarTontonFilmBloc must be emit [success] when remove movie item to watchlist is successful',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => const Right("Removed"));

      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveItemMovieEvent(testMovieDetail)),
    expect: () => [const MovieWatchlistSuccess("Removed")],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<DaftarTontonFilmBloc, StateDaftarTontonFilm>(
    'DaftarTontonFilmBloc must be emit [error] when add movie item to watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));

      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(AddItemMovieEvent(testMovieDetail)),
    expect: () => [const MovieWatchlistError("Failed")],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<DaftarTontonFilmBloc, StateDaftarTontonFilm>(
    'DaftarTontonFilmBloc must be emit [error] when remove movie item to watchlist is unsuccessful',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));

      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(RemoveItemMovieEvent(testMovieDetail)),
    expect: () => [const MovieWatchlistError("Failed")],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'MovieTopRatedBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));

      return movieTopRatedBloc;
    },
    act: (bloc) => bloc.add(MovieTopRatedGetEvent()),
    expect: () => [MovieTopRatedLoading(), MovieTopRatedLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'MovieTopRatedBloc must be emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return movieTopRatedBloc;
    },
    act: (bloc) => bloc.add(MovieTopRatedGetEvent()),
    expect: () =>
        [MovieTopRatedLoading(), MovieTopRatedError('Server Failure')],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'MovieSearchBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(query))
          .thenAnswer((_) async => Right(testMovieList));

      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(const MovieSearchQueryEvent(query)),
    expect: () => [MovieSearchLoading(), MovieSearchLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockSearchMovies.execute(query));
    },
  );

  blocTest<MovieSearchBloc, MovieSearchState>(
    'MovieSearchBloc must be emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(query))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return movieSearchBloc;
    },
    act: (bloc) => bloc.add(const MovieSearchQueryEvent(query)),
    expect: () =>
        [MovieSearchLoading(), const MovieSearchError('Server Failure')],
    verify: (bloc) {
      verify(mockSearchMovies.execute(query));
    },
  );

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'MovieRecommendationBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendation.execute(revId))
          .thenAnswer((_) async => Right(testMovieList));

      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(const GetMovieRecommendationEvent(revId)),
    expect: () => [
      MovieRecommendationLoading(),
      MovieRecommendationLoaded(testMovieList)
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendation.execute(revId));
    },
  );

  blocTest<MovieRecommendationBloc, MovieRecommendationState>(
    'MovieRecommendationBloc must emit [Loading, Error] when get recommendation is unsuccessful',
    build: () {
      when(mockGetMovieRecommendation.execute(revId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return movieRecommendationBloc;
    },
    act: (bloc) => bloc.add(const GetMovieRecommendationEvent(revId)),
    expect: () => [
      MovieRecommendationLoading(),
      const MovieRecommendationError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendation.execute(revId));
    },
  );

  blocTest<MoviePopularBloc, MoviePopularState>(
      'MoviePopularBloc must be emit [loading, loaded] when data is loaded successfully',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));

        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(MoviePopularGetEvent()),
      expect: () => [MoviePopularLoading(), MoviePopularLoaded(testMovieList)],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      });

  blocTest<MoviePopularBloc, MoviePopularState>(
      'MoviePopularBloc must be emit [loading, error] when data is failed to loaded',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(MoviePopularGetEvent()),
      expect: () =>
          [MoviePopularLoading(), MoviePopularError('Server Failure')],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      });

  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
    'MovieNowPlayingBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));

      return movieNowPlayingBloc;
    },
    act: (bloc) => bloc.add(MovieNowPlayingGetEvent()),
    expect: () =>
        [MovieNowPlayingLoading(), MovieNowPlayingLoaded(testMovieList)],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
    'MovieNowPlayingBloc must be emit [Loading, Error] when get now playing is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return movieNowPlayingBloc;
    },
    act: (bloc) => bloc.add(MovieNowPlayingGetEvent()),
    expect: () => [
      MovieNowPlayingLoading(),
      const MovieNowPlayingError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<DetailFilmBloc, StateDetailFilm>(
    'DetailFilmBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockAmbilDataDetailFilm.execute(revId))
          .thenAnswer((_) async => Right(testMovieDetail));

      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(const GetEventDetailFilm(revId)),
    expect: () => [MovieDetailLoading(), MovieDetailLoaded(testMovieDetail)],
    verify: (bloc) {
      verify(mockAmbilDataDetailFilm.execute(revId));
    },
  );

  blocTest<DetailFilmBloc, StateDetailFilm>(
    'DetailFilmBloc must be emit [Loading, Error] when get detail is unsuccessful',
    build: () {
      when(mockAmbilDataDetailFilm.execute(revId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return movieDetailBloc;
    },
    act: (bloc) => bloc.add(const GetEventDetailFilm(revId)),
    expect: () =>
        [MovieDetailLoading(), const MovieDetailError('Server Failure')],
    verify: (bloc) {
      verify(mockAmbilDataDetailFilm.execute(revId));
    },
  );
}

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cinta_film/presentasi/bloc/tv_bloc.dart';
import 'package:cinta_film/data/lib_server_fail.dart';

import '../../dummy_data/dummy_objects_tvls.dart';
import '../../helpers/test_helper_tvls.mocks.dart';

void main() {
  
  late MockGetwatchlistTvls mockGetWatchlistTvSeries;
  late MockClassStatusDaftarTontonTvls mockGetWatchListStatusTvSeries;
  late MockClassSimpanDaftarTontonTvls mockSaveWatchlistTvSeries;
  late MockClassHapusDaftarTontonTvls mockRemoveWatchlistTvSeries;
  late MockSearchTvls mockSearchTvSeries;
  late MockGetTopRatedTvls mockGetTopRatedTvSeries;
  late MockGetTvlsDetail mockGetTvSeriesDetail;
  late MockGetTvlsRecommendations mockGetTvSeriesRecommendations;
  late MockGetPopularTvls mockGetPopularTvSeries;
  late MockGetserialTvSaatIniDiPutarls mockGetNowPlayingTvSeries;

  late OnTheAirTvseriesBloc onTheAirTvseriesBloc;
  late TvseriesRecommendationsBloc tvseriesRecommendationsBloc;
  late TvseriesDetailBloc tvseriesDetailBloc;
  late TvseriesSearchBloc tvseriesSearchBloc;
  late TopRatedTvseriesBloc topRatedTvseriesBloc;
  late WatchlistTvseriesBloc watchlistTvseriesBloc;
  late PopularTvseriesBloc popularTvseriesBloc;

  setUp(() {
    mockGetWatchlistTvSeries        = MockGetwatchlistTvls();
    mockGetWatchListStatusTvSeries  = MockClassStatusDaftarTontonTvls();
    mockSaveWatchlistTvSeries       = MockClassSimpanDaftarTontonTvls();
    mockRemoveWatchlistTvSeries     = MockClassHapusDaftarTontonTvls();
    mockSearchTvSeries              = MockSearchTvls();
    mockGetTvSeriesRecommendations  = MockGetTvlsRecommendations();
    mockGetTvSeriesDetail           = MockGetTvlsDetail();
    mockGetTopRatedTvSeries         = MockGetTopRatedTvls();
    mockGetPopularTvSeries          = MockGetPopularTvls();
    mockGetNowPlayingTvSeries       = MockGetserialTvSaatIniDiPutarls();

    onTheAirTvseriesBloc            = OnTheAirTvseriesBloc(mockGetNowPlayingTvSeries);
    popularTvseriesBloc             = PopularTvseriesBloc(mockGetPopularTvSeries);
    tvseriesDetailBloc              = TvseriesDetailBloc(mockGetTvSeriesDetail);
    tvseriesSearchBloc              = TvseriesSearchBloc(mockSearchTvSeries);
    tvseriesRecommendationsBloc     = TvseriesRecommendationsBloc(mockGetTvSeriesRecommendations);
    topRatedTvseriesBloc            = TopRatedTvseriesBloc(mockGetTopRatedTvSeries);
    watchlistTvseriesBloc           = WatchlistTvseriesBloc(
        mockGetWatchlistTvSeries,
        mockGetWatchListStatusTvSeries,
        mockSaveWatchlistTvSeries,
        mockRemoveWatchlistTvSeries);
  });

  const revtvseriesId = 1;
  const query = "originalTitle";

  test("WatchlistTvseriesBloc must be initial state should be empty", () {
    expect(watchlistTvseriesBloc.state, WatchlistTvseriesEmpty());
  });

  test("TvseriesSearchBloc must be initial state should be empty", () {
    expect(tvseriesSearchBloc.state, TvseriesSearchEmpty());
  });

  test("TvseriesRecommendationsBloc must be initial state should be empty", () {
    expect(tvseriesRecommendationsBloc.state, TvseriesRecommendationsEmpty());
  });

  test("TvseriesDetailBloc must be initial state should be empty", () {
    expect(tvseriesDetailBloc.state, TvseriesDetailEmpty());
  });

  test("TopRatedTvseriesBloc must be initial state should be empty", () {
    expect(topRatedTvseriesBloc.state, TopRatedTvseriesEmpty());
  });

  test("PopularTvseriesBloc must be initial state should be empty", () {
    expect(popularTvseriesBloc.state, PopularTvseriesEmpty());
  });

  test("OnTheAirTvseriesBloc must be initial state should be empty", () {
    expect(onTheAirTvseriesBloc.state, OnTheAirTvseriesEmpty());
  });

  blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>( 
    'WatchlistTvseriesBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Right(testTvList));
      return watchlistTvseriesBloc;
    },
    act: (bloc) => bloc.add(WatchlistTvseriesGetEvent()),
    expect: () =>
        [WatchlistTvseriesLoading(), WatchlistTvseriesLoaded(testTvList)],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );

  blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>(
    'WatchlistTvseriesBloc must be emit [Loading, Error] when get watchlist is unsuccessful',
    build: () {
      when(mockGetWatchlistTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure("Can't get data")));
      return watchlistTvseriesBloc;
    },
    act: (bloc) => bloc.add(WatchlistTvseriesGetEvent()),
    expect: () => [
      WatchlistTvseriesLoading(),
      const WatchlistTvseriesError("Can't get data")
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvSeries.execute());
    },
  );

  blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>(
    'WatchlistTvseriesBloc must be emit [Loaded] when get status tv watchlist is successful',
    build: () {
      when(mockGetWatchListStatusTvSeries.execute(revtvseriesId))
          .thenAnswer((_) async => true);
      return watchlistTvseriesBloc;
    },
    act: (bloc) =>
        bloc.add(const WatchlistTvseriesGetStatusEvent(revtvseriesId)),
    expect: () => [const WatchlistTvseriesStatusLoaded(true)],
    verify: (bloc) {
      verify(mockGetWatchListStatusTvSeries.execute(revtvseriesId));
    },
  );

  blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>(
    'WatchlistTvseriesBloc must be emit [success] when add tv item to watchlist is successful',
    build: () {
      when(mockSaveWatchlistTvSeries.execute(testTvDetail))
          .thenAnswer((_) async => const Right("Success"));
      return watchlistTvseriesBloc;
    },
    act: (bloc) => bloc.add(WatchlistTvseriesTambahItemEvent(testTvDetail)),
    expect: () => [const WatchlistTvseriesSuccess("Success")],
    verify: (bloc) {
      verify(mockSaveWatchlistTvSeries.execute(testTvDetail));
    },
  );

  blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>(
    'WatchlistTvseriesBloc must be emit [success] when remove tv item to watchlist is successful',
    build: () {
      when(mockRemoveWatchlistTvSeries.execute(testTvDetail))
          .thenAnswer((_) async => const Right("Removed"));
      return watchlistTvseriesBloc;
    },
    act: (bloc) => bloc.add(WatchlistTvseriesHapusItemEvent(testTvDetail)),
    expect: () => [const WatchlistTvseriesSuccess("Removed")],
    verify: (bloc) {
      verify(mockRemoveWatchlistTvSeries.execute(testTvDetail));
    },
  );

  blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>(
    'WatchlistTvseriesBloc must be emit [error] when add tv item to watchlist is unsuccessful',
    build: () {
      when(mockSaveWatchlistTvSeries.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return watchlistTvseriesBloc;
    },
    act: (bloc) => bloc.add(WatchlistTvseriesTambahItemEvent(testTvDetail)),
    expect: () => [const WatchlistTvseriesError("Failed")],
    verify: (bloc) {
      verify(mockSaveWatchlistTvSeries.execute(testTvDetail));
    },
  );

  blocTest<WatchlistTvseriesBloc, WatchlistTvseriesState>(
    'WatchlistTvseriesBloc must be emit [error] when remove tv item to watchlist is unsuccessful',
    build: () {
      when(mockRemoveWatchlistTvSeries.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      return watchlistTvseriesBloc;
    },
    act: (bloc) => bloc.add(WatchlistTvseriesHapusItemEvent(testTvDetail)),
    expect: () => [const WatchlistTvseriesError("Failed")],
    verify: (bloc) {
      verify(mockRemoveWatchlistTvSeries.execute(testTvDetail));
    },
  );

  blocTest<TvseriesSearchBloc, TvseriesSearchState>(
    'TvseriesSearchBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockSearchTvSeries.execute(query))
          .thenAnswer((_) async => Right(testTvList));
      return tvseriesSearchBloc;
    },
    act: (bloc) => bloc.add(const TvseriesSearchQueryEvent(query)),
    expect: () => [TvseriesSearchLoading(), TvseriesSearchLoaded(testTvList)],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(query));
    },
  );

  blocTest<TvseriesSearchBloc, TvseriesSearchState>(
    'TvseriesSearchBloc must be [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTvSeries.execute(query))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvseriesSearchBloc;
    },
    act: (bloc) => bloc.add(const TvseriesSearchQueryEvent(query)),
    expect: () =>
        [TvseriesSearchLoading(), const TvseriesSearchError('Server Failure')],
    verify: (bloc) {
      verify(mockSearchTvSeries.execute(query));
    },
  );

  blocTest<TvseriesRecommendationsBloc, TvseriesRecommendationsState>(
    'TvseriesRecommendationsBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(revtvseriesId))
          .thenAnswer((_) async => Right(testTvList));

      return tvseriesRecommendationsBloc;
    },
    act: (bloc) =>
        bloc.add(const TvseriesRecommendationsGetEvent(revtvseriesId)),
    expect: () => [
      TvseriesRecommendationsLoading(),
      TvseriesRecommendationsLoaded(testTvList)
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendations.execute(revtvseriesId));
    },
  );

  blocTest<TvseriesRecommendationsBloc, TvseriesRecommendationsState>(
    'TvseriesRecommendationsBloc must be emit [Loading, Error] when get recommendation is unsuccessful',
    build: () {
      when(mockGetTvSeriesRecommendations.execute(revtvseriesId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return tvseriesRecommendationsBloc;
    },
    act: (bloc) =>
        bloc.add(const TvseriesRecommendationsGetEvent(revtvseriesId)),
    expect: () => [
      TvseriesRecommendationsLoading(),
      const TvseriesRecommendationsError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockGetTvSeriesRecommendations.execute(revtvseriesId));
    },
  );

  blocTest<TvseriesDetailBloc, TvseriesDetailState>(
    'TvseriesDetailBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetTvSeriesDetail.execute(revtvseriesId))
          .thenAnswer((_) async => Right(testTvDetail));

      return tvseriesDetailBloc;
    },
    act: (bloc) => bloc.add(const TvseriesDetailGetEvent(revtvseriesId)),
    expect: () => [TvseriesDetailLoading(), TvseriesDetailLoaded(testTvDetail)],
    verify: (bloc) {
      verify(mockGetTvSeriesDetail.execute(revtvseriesId));
    },
  );

  blocTest<TvseriesDetailBloc, TvseriesDetailState>(
    'TvseriesDetailBloc must be emit [Loading, Error] when get detail is unsuccessful',
    build: () {
      when(mockGetTvSeriesDetail.execute(revtvseriesId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return tvseriesDetailBloc;
    },
    act: (bloc) => bloc.add(const TvseriesDetailGetEvent(revtvseriesId)),
    expect: () =>
        [TvseriesDetailLoading(), const TvseriesDetailError('Server Failure')],
    verify: (bloc) {
      verify(mockGetTvSeriesDetail.execute(revtvseriesId));
    },
  );

  blocTest<TopRatedTvseriesBloc, TopRatedTvseriesState>(
    'TopRatedTvseriesBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(testTvList));

      return topRatedTvseriesBloc;
    },
    act: (bloc) => bloc.add(TopRatedTvseriesGetEvent()),
    expect: () =>
        [TopRatedTvseriesLoading(), TopRatedTvseriesLoaded(testTvList)],
    verify: (bloc) {
      verify(mockGetTopRatedTvSeries.execute());
    },
  );

  blocTest<TopRatedTvseriesBloc, TopRatedTvseriesState>(
    'TopRatedTvseriesBloc must be emit [Loading, Error] when get top rated is unsuccessful',
    build: () {
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return topRatedTvseriesBloc;
    },
    act: (bloc) => bloc.add(TopRatedTvseriesGetEvent()),
    expect: () => [
      TopRatedTvseriesLoading(),
      const TopRatedTvseriesError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvSeries.execute());
    },
  );

  blocTest<PopularTvseriesBloc, PopularTvseriesState>(
    'PopularTvseriesBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(testTvList));

      return popularTvseriesBloc;
    },
    act: (bloc) => bloc.add(PopularTvseriesGetEvent()),
    expect: () => [PopularTvseriesLoading(), PopularTvseriesLoaded(testTvList)],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    },
  );

  blocTest<PopularTvseriesBloc, PopularTvseriesState>(
    'PopularTvseriesBloc must be emit [Loading, Error] when get popular is unsuccessful',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return popularTvseriesBloc;
    },
    act: (bloc) => bloc.add(PopularTvseriesGetEvent()),
    expect: () =>
        [PopularTvseriesLoading(), PopularTvseriesError('Server Failure')],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    },
  );

  blocTest<OnTheAirTvseriesBloc, OnTheAirTvseriesState>(
    'OnTheAirTvseriesBloc must be emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Right(testTvList));

      return onTheAirTvseriesBloc;
    },
    act: (bloc) => bloc.add(OnTheAirTvseriesGetEvent()),
    expect: () =>
        [OnTheAirTvseriesLoading(), OnTheAirTvseriesLoaded(testTvList)],
    verify: (bloc) {
      verify(mockGetNowPlayingTvSeries.execute());
    },
  );

  blocTest<OnTheAirTvseriesBloc, OnTheAirTvseriesState>(
    'OnTheAirTvseriesBloc must be emit [Loading, Error] when get now playing is unsuccessful',
    build: () {
      when(mockGetNowPlayingTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));

      return onTheAirTvseriesBloc;
    },
    act: (bloc) => bloc.add(OnTheAirTvseriesGetEvent()),
    expect: () => [
      OnTheAirTvseriesLoading(),
      const OnTheAirTvseriesError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvSeries.execute());
    },
  );
}

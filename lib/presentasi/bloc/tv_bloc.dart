import 'package:cinta_film/domain/get_data_tv.dart';
import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
part 'tv_state.dart';
part 'tv_event.dart';

class WatchlistTvseriesBloc
    extends Bloc<WatchlistTvseriesEvent, WatchlistTvseriesState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  final ClassStatusDaftarTontonTvls _getWatchListStatusTvseries;
  final GetwatchlistTvls _getWatchlistTvseries;
  final ClassHapusDaftarTontonTvls _removeWatchlistTvseries;
  final ClassSimpanDaftarTontonTvls _saveWatchlistTvseries;

  WatchlistTvseriesBloc(
    this._getWatchlistTvseries,
    this._getWatchListStatusTvseries,
    this._saveWatchlistTvseries,
    this._removeWatchlistTvseries,
  ) : super(WatchlistTvseriesEmpty()) {
    on<WatchlistTvseriesGetEvent>((event, emit) async {
      emit(WatchlistTvseriesLoading());

      final result = await _getWatchlistTvseries.execute();

      result.fold(
        (failure) {
          emit(WatchlistTvseriesError(failure.message));
        },
        (data) {
          emit(WatchlistTvseriesLoaded(data));
        },
      );
    });

    on<WatchlistTvseriesGetStatusEvent>((event, emit) async {
      final id = event.id;

      final result = await _getWatchListStatusTvseries.execute(id);

      emit(WatchlistTvseriesStatusLoaded(result));
    });

    on<WatchlistTvseriesTambahItemEvent>((event, emit) async {
      final tvSeriesDetail = event.tvSeriesDetail;

      final result = await _saveWatchlistTvseries.execute(tvSeriesDetail);

      result.fold(
        (failure) {
          emit(WatchlistTvseriesError(failure.message));
        },
        (successMessage) {
          emit(WatchlistTvseriesSuccess(successMessage));
        },
      );
    });

    on<WatchlistTvseriesHapusItemEvent>((event, emit) async {
      final tvSeriesDetail = event.tvSeriesDetail;

      final result = await _removeWatchlistTvseries.execute(tvSeriesDetail);

      result.fold(
        (failure) {
          emit(WatchlistTvseriesError(failure.message));
        },
        (successMessage) {
          emit(WatchlistTvseriesSuccess(successMessage));
        },
      );
    });
  }
}


class TvseriesDetailBloc
    extends Bloc<TvseriesDetailEvent, TvseriesDetailState> {
  final GetTvlsDetail _getTvseriesDetail;

  TvseriesDetailBloc(
    this._getTvseriesDetail,
  ) : super(TvseriesDetailEmpty()) {
    on<TvseriesDetailGetEvent>((event, emit) async {
      emit(TvseriesDetailLoading());

      final result = await _getTvseriesDetail.execute(event.id);

      result.fold((failure) => emit(TvseriesDetailError(failure.message)),
          (data) => emit(TvseriesDetailLoaded(data)));
    });
  }
}

class TvseriesSearchBloc
    extends Bloc<TvseriesSearchEvent, TvseriesSearchState> {
  final SearchTvls _searchTvSeries;

  TvseriesSearchBloc(
    this._searchTvSeries,
  ) : super(TvseriesSearchEmpty()) {
    on<TvseriesSearchSetEmpty>((event, emit) => emit(TvseriesSearchEmpty()));

    on<TvseriesSearchQueryEvent>((event, emit) async {
      emit(TvseriesSearchLoading());

      final result = await _searchTvSeries.execute(event.query);

      result.fold(
        (failure) {
          emit(TvseriesSearchError(failure.message));
        },
        (data) {
          emit(TvseriesSearchLoaded(data));
        },
      );
    });
  }
}

class TopRatedTvseriesBloc
    extends Bloc<TopRatedTvseriesEvent, TopRatedTvseriesState> {
  final GetTopRatedTvls _getTopRatedTvseries;

  TopRatedTvseriesBloc(
    this._getTopRatedTvseries,
  ) : super(TopRatedTvseriesEmpty()) {
    on<TopRatedTvseriesGetEvent>((event, emit) async {
      emit(TopRatedTvseriesLoading());

      final result = await _getTopRatedTvseries.execute();

      result.fold(
        (failure) {
          emit(TopRatedTvseriesError(failure.message));
        },
        (data) {
          emit(TopRatedTvseriesLoaded(data));
        },
      );
    });
  }
}

class TvseriesRecommendationsBloc
    extends Bloc<TvseriesRecommendationsEvent, TvseriesRecommendationsState> {
  final GetTvlsRecommendations _getTvseriesRecommendations;

  TvseriesRecommendationsBloc(
    this._getTvseriesRecommendations,
  ) : super(TvseriesRecommendationsEmpty()) {
    on<TvseriesRecommendationsGetEvent>((event, emit) async {
      emit(TvseriesRecommendationsLoading());

      final result = await _getTvseriesRecommendations.execute(event.id);

      result.fold(
        (failure) {
          emit(TvseriesRecommendationsError(failure.message));
        },
        (data) {
          emit(TvseriesRecommendationsLoaded(data));
        },
      );
    });
  }
}


class OnTheAirTvseriesBloc
    extends Bloc<OnTheAirTvseriesEvent, OnTheAirTvseriesState> {
  final GetserialTvSaatIniDiPutarls _getOnAirTvseries;

  OnTheAirTvseriesBloc(
    this._getOnAirTvseries,
  ) : super(OnTheAirTvseriesEmpty()) {
    on<OnTheAirTvseriesGetEvent>((event, emit) async {
      emit(OnTheAirTvseriesLoading());

      final result = await _getOnAirTvseries.execute();

      result.fold((failure) => emit(OnTheAirTvseriesError(failure.message)),
          (data) => emit(OnTheAirTvseriesLoaded(data)));
    });
  }
}

class PopularTvseriesBloc extends Bloc<PopularTvseriesEvent, PopularTvseriesState> {
  final GetPopularTvls _getPopularTvseries;
  PopularTvseriesBloc(this._getPopularTvseries) : super(PopularTvseriesEmpty()) {
    
    on<PopularTvseriesGetEvent>(
      (event, emit) async {
        emit(PopularTvseriesLoading()
    );
    
    final result = await _getPopularTvseries.execute();

      result.fold((failure) {
        emit(PopularTvseriesError(failure.message));
      },
      (data) {
        emit(PopularTvseriesLoaded(data));
      },
    );
    });
  }
}

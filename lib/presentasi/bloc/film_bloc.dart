import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/domain/entities/movie_detail.dart';
import 'package:cinta_film/domain/get_data_film.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
part 'film_event.dart';
part 'film_state.dart';


class DaftarTontonFilmBloc extends Bloc<EventDaftarTontonFilm, StateDaftarTontonFilm> {
  
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  static const watchlistAddSuccessMessage = 'Added to Watchlist';

  final ClassStatusDaftarTonton getWatchListStatus;
  final ClassDaftarTontonFilm getWatchlistMovies;
  final ClassHapusDaftarTonton removeWatchlist;
  final ClassSimpanDaftarTonton saveWatchlist;

  DaftarTontonFilmBloc({
    required this.getWatchlistMovies,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieWatchlistEmpty()) {
    on<GetListEvent>((event, emit) async {
      emit(MovieWatchlistLoading());

      final result = await getWatchlistMovies.execute();

      result.fold(
        (failure) {
          emit(MovieWatchlistError(failure.message));
        },
        (data) {
          emit(MovieWatchlistLoaded(data));
        },
      );
    });

    on<GetStatusMovieEvent>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);

      emit(MovieWatchlistStatusLoaded(result));
    });

    on<AddItemMovieEvent>((event, emit) async {
      final movieDetail = event.movieDetail;

      final result = await saveWatchlist.execute(movieDetail);

      result.fold(
        (failure) {
          emit(MovieWatchlistError(failure.message));
        },
        (successMessage) {
          emit(MovieWatchlistSuccess(successMessage));
        },
      );
    });

    on<RemoveItemMovieEvent>((event, emit) async {
      final movieDetail = event.movieDetail;

      final result = await removeWatchlist.execute(movieDetail);

      result.fold(
        (failure) {
          emit(MovieWatchlistError(failure.message));
        },
        (successMessage) {
          emit(MovieWatchlistSuccess(successMessage));
        },
      );
    });
  }
}

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final ClassFilmRatingTerbaik getTopRatedMovies;

  MovieTopRatedBloc(
    this.getTopRatedMovies,
  ) : super(MovieTopRatedEmpty()) {
    on<MovieTopRatedGetEvent>((event, emit) async {
      emit(MovieTopRatedLoading());

      final result = await getTopRatedMovies.execute();

      result.fold(
        (failure) {
          emit(MovieTopRatedError(failure.message));
        },
        (data) {
          emit(MovieTopRatedLoaded(data));
        },
      );
    });
  }
}

class DetailFilmBloc extends Bloc<EventDetailFilm, StateDetailFilm> {
  final AmbilDataDetailFilm getMovieDetail;

  DetailFilmBloc({
    required this.getMovieDetail,
  }) : super(DataDetailFilmKosong()) {
    on<GetEventDetailFilm>((event, emit) async {
      emit(MovieDetailLoading());

      final result = await getMovieDetail.execute(event.id);

      result.fold(
        (failure) {
          emit(MovieDetailError(failure.message));
        },
        (data) {
          emit(MovieDetailLoaded(data));
        },
      );
    });
  }
}

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final ClassCariFilm searchMovies;

  MovieSearchBloc({
    required this.searchMovies,
  }) : super(MovieSearchEmpty()) {
    on<MovieSearchSetEmpty>((event, emit) => emit(MovieSearchEmpty()));

    on<MovieSearchQueryEvent>((event, emit) async {
      emit(MovieSearchLoading());

      final result = await searchMovies.execute(event.query);

      result.fold(
        (failure) {
          emit(MovieSearchError(failure.message));
        },
        (data) {
          emit(MovieSearchLoaded(data));
        },
      );
    });
  }
}

class MovieRecommendationBloc extends Bloc<MovieRecommendationEvent, MovieRecommendationState> {
  final AmbilDataRekomendasiFilm getMovieRecommendations;

  MovieRecommendationBloc({
    required this.getMovieRecommendations,
  }) : super(MovieRecommendationEmpty()) {
    on<GetMovieRecommendationEvent>((event, emit) async {
      emit(MovieRecommendationLoading());

      final result = await getMovieRecommendations.execute(event.id);

      result.fold(
        (failure) {
          emit(MovieRecommendationError(failure.message));
        },
        (data) {
          emit(MovieRecommendationLoaded(data));
        },
      );
    });
  }
}

class MovieNowPlayingBloc extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final ClasFilmTayangSaatIni getNowPlayingMovies;

  MovieNowPlayingBloc(
    this.getNowPlayingMovies,
  ) : super(MovieNowPlayingEmpty()) {
    on<MovieNowPlayingGetEvent>((event, emit) async {
      emit(MovieNowPlayingLoading());

      final result = await getNowPlayingMovies.execute();

      result.fold(
        (failure) {
          emit(MovieNowPlayingError(failure.message));
        },
        (data) {
          emit(MovieNowPlayingLoaded(data));
        },
      );
    });
  }
}

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final ClassFilmTerPopuler getPopularMovies;

  MoviePopularBloc(
    this.getPopularMovies,
  ) : super(MoviePopularEmpty()) {
    on<MoviePopularGetEvent>((event, emit) async {
      emit(MoviePopularLoading());

      final film = await getPopularMovies.execute();

      film.fold(
        (failure) {
          emit(MoviePopularError(failure.message));
        },
        (data) {
          emit(MoviePopularLoaded(data));
        },
      );
    });
  }
}

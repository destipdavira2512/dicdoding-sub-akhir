part of 'film_bloc.dart';

class MovieWatchlistSuccess extends StateDaftarTontonFilm {
  final String message;

  const MovieWatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistError extends StateDaftarTontonFilm {
  final String message;

  const MovieWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistStatusLoaded extends StateDaftarTontonFilm {
  final bool result;

  const MovieWatchlistStatusLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class MovieWatchlistLoaded extends StateDaftarTontonFilm {
  final List<Film> result;

  const MovieWatchlistLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class MovieDetailError extends StateDetailFilm {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailLoaded extends StateDetailFilm {
  final MovieDetail movieDetail;

  const MovieDetailLoaded(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class MovieTopRatedLoaded extends MovieTopRatedState {
  final List<Film> result;

  const MovieTopRatedLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class MovieTopRatedError extends MovieTopRatedState {
  final String message;

  const MovieTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}


abstract class MovieTopRatedState extends Equatable {
  const MovieTopRatedState();

  @override
  List<Object> get props => [];
}

abstract class StateDetailFilm extends Equatable {
  const StateDetailFilm();

  @override
  List<Object> get props => [];
}

abstract class StateDaftarTontonFilm extends Equatable {
  const StateDaftarTontonFilm();

  @override
  List<Object> get props => [];
}


class MovieDetailLoading extends StateDetailFilm {}


class DataDetailFilmKosong extends StateDetailFilm {}

class MovieTopRatedEmpty extends MovieTopRatedState {}
class MovieTopRatedLoading extends MovieTopRatedState {}
class MovieWatchlistEmpty extends StateDaftarTontonFilm {}
class MovieWatchlistLoading extends StateDaftarTontonFilm {}



@immutable
abstract class MainFilmState extends Equatable{
    const MainFilmState();
}

// MOVIE POPULER STATE //
class MoviePopularState extends MainFilmState{
  const MoviePopularState();
  @override
  List<Object> get props => [];
}
class MoviePopularLoaded extends MoviePopularState {
  final List<Film> result;
  const MoviePopularLoaded(this.result);
  @override
  List<Object> get props => [result];
}
class MoviePopularError extends MoviePopularState {
  final String message;
  const MoviePopularError(this.message);
  @override
  List<Object> get props => [message];
}
class MoviePopularLoading extends MoviePopularState {}
class MoviePopularEmpty extends MoviePopularState {}
// MOVIE POPULER STATE //

// MOVIE SEARCH STATE //
class MovieSearchState extends MainFilmState {
  const MovieSearchState();
  @override
  List<Object> get props => [];
}
class MovieSearchLoaded extends MovieSearchState {
  final List<Film> result;
  const MovieSearchLoaded(this.result);
  @override
  List<Object> get props => [result];
}
class MovieSearchError extends MovieSearchState {
  final String message;
  const MovieSearchError(this.message);
  @override
  List<Object> get props => [message];
}
class MovieSearchLoading extends MovieSearchState {}
class MovieSearchEmpty extends MovieSearchState {}
// MOVIE SEARCH STATE //

// MOVIE PLAYING STATE //
class MovieNowPlayingState extends MainFilmState {
  const MovieNowPlayingState();
  @override
  List<Object> get props => [];
}
class MovieNowPlayingLoaded extends MovieNowPlayingState {
  final List<Film> result;
  const MovieNowPlayingLoaded(this.result);
  @override
  List<Object> get props => [result];
}
class MovieNowPlayingError extends MovieNowPlayingState {
  final String message;
  const MovieNowPlayingError(this.message);
  @override
  List<Object> get props => [message];
}
class MovieNowPlayingEmpty extends MovieNowPlayingState {}
class MovieNowPlayingLoading extends MovieNowPlayingState {}
// MOVIE PLAYING STATE //

//MOVIE RECOMENDATION STATE //
class MovieRecommendationState extends MainFilmState{
  const MovieRecommendationState();
  @override
  List<Object> get props => [];
}
class MovieRecommendationLoaded extends MovieRecommendationState {
  final List<Film> movie;
  const MovieRecommendationLoaded(this.movie);
  @override
  List<Object> get props => [movie];
}
class MovieRecommendationError extends MovieRecommendationState {
  final String message;
  const MovieRecommendationError(this.message);
  @override
  List<Object> get props => [message];
}
class MovieRecommendationEmpty extends MovieRecommendationState {}
class MovieRecommendationLoading extends MovieRecommendationState {}
// MOVIE RECOMENDATION STATE //

part of 'film_bloc.dart';

abstract class EventDaftarTontonFilm extends Equatable {
const EventDaftarTontonFilm();

  @override
  List<Object> get props => [];
}

class GetListEvent extends EventDaftarTontonFilm {}

class GetStatusTvEvent extends EventDaftarTontonFilm {
  final int id;

  const GetStatusTvEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetStatusMovieEvent extends EventDaftarTontonFilm {
  final int id;

  const GetStatusMovieEvent(this.id);

  @override
  List<Object> get props => [id];
}

class RemoveItemMovieEvent extends EventDaftarTontonFilm {
  final MovieDetail movieDetail;

  const RemoveItemMovieEvent(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class AddItemMovieEvent extends EventDaftarTontonFilm {
  final MovieDetail movieDetail;

  const AddItemMovieEvent(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

abstract class EventDetailFilm extends Equatable {
  const EventDetailFilm();

  @override
  List<Object> get props => [];
}

class GetEventDetailFilm extends EventDetailFilm {
  final int id;

  const GetEventDetailFilm(this.id);

  @override
  List<Object> get props => [];
}

abstract class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object> get props => [];
}

class MovieSearchQueryEvent extends MovieSearchEvent {
  final String query;

  const MovieSearchQueryEvent(this.query);

  @override
  List<Object> get props => [];
}

class MovieSearchSetEmpty extends MovieSearchEvent {}

abstract class MovieTopRatedEvent extends Equatable {
  const MovieTopRatedEvent();
  @override
  List<Object> get props => [];
}

class MovieTopRatedGetEvent extends MovieTopRatedEvent {}

abstract class MovieRecommendationEvent extends Equatable {
  const MovieRecommendationEvent();
  @override
  List<Object> get props => [];
}

class GetMovieRecommendationEvent extends MovieRecommendationEvent {
  final int id;
  const GetMovieRecommendationEvent(this.id);
  @override
  List<Object> get props => [];
}

abstract class MovieNowPlayingEvent extends Equatable {
  const MovieNowPlayingEvent();
  @override
  List<Object> get props => [];
}

class MovieNowPlayingGetEvent extends MovieNowPlayingEvent {}

abstract class MoviePopularEvent extends Equatable {
  const MoviePopularEvent();
  @override
  List<Object> get props => [];
}

class MoviePopularGetEvent extends MoviePopularEvent {}

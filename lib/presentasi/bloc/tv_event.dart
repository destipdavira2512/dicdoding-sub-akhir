part of 'tv_bloc.dart';

@immutable
abstract class MainEventTV extends Equatable{
  const MainEventTV();
}

class PopularTvseriesEvent extends MainEventTV{
  const PopularTvseriesEvent();
  List<Object> get props => [];
}
class PopularTvseriesGetEvent extends PopularTvseriesEvent {}

class OnTheAirTvseriesEvent extends MainEventTV{
  const OnTheAirTvseriesEvent();
  List<Object> get props => [];
}
class OnTheAirTvseriesGetEvent extends OnTheAirTvseriesEvent {}

class TvseriesRecommendationsEvent extends MainEventTV{
  const TvseriesRecommendationsEvent();
  List<Object> get props => [];
}
class TvseriesRecommendationsGetEvent extends TvseriesRecommendationsEvent {
  final int id;
  const TvseriesRecommendationsGetEvent(this.id);
  List<Object> get props => [];
}

class TopRatedTvseriesEvent extends MainEventTV {
  const TopRatedTvseriesEvent();
  List<Object> get props => [];
}
class TopRatedTvseriesGetEvent extends TopRatedTvseriesEvent {}

class TvseriesSearchEvent extends MainEventTV{
  const TvseriesSearchEvent();
  List<Object> get props => [];
}
class TvseriesSearchQueryEvent extends TvseriesSearchEvent {
  final String query;
  const TvseriesSearchQueryEvent(this.query);
  List<Object> get props => [];
}
class TvseriesSearchSetEmpty extends TvseriesSearchEvent {}

class TvseriesDetailEvent extends MainEventTV{
  const TvseriesDetailEvent();
  List<Object> get props => [];
}
class TvseriesDetailGetEvent extends TvseriesDetailEvent {
  final int id;
  const TvseriesDetailGetEvent(this.id);
  List<Object> get props => [];
}

class WatchlistTvseriesEvent extends MainEventTV{
  const WatchlistTvseriesEvent();
  List<Object> get props => [];
}
class WatchlistTvseriesGetStatusEvent extends WatchlistTvseriesEvent {
  final int id;
  const WatchlistTvseriesGetStatusEvent(this.id);
  List<Object> get props => [id];
}
class WatchlistTvseriesHapusItemEvent extends WatchlistTvseriesEvent {
  final TvlsDetail tvSeriesDetail;
  const WatchlistTvseriesHapusItemEvent(this.tvSeriesDetail); 
  List<Object> get props => [tvSeriesDetail];
}
class WatchlistTvseriesTambahItemEvent extends WatchlistTvseriesEvent {
  final TvlsDetail tvSeriesDetail;
  const WatchlistTvseriesTambahItemEvent(this.tvSeriesDetail);
  List<Object> get props => [tvSeriesDetail];
}
class WatchlistTvseriesGetEvent extends WatchlistTvseriesEvent {}
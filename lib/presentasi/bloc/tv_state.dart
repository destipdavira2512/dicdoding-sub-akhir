part of 'tv_bloc.dart';

@immutable
abstract class MainStateTv extends Equatable{ 
  const MainStateTv();
}

class PopularTvseriesState extends MainStateTv {
  const PopularTvseriesState(); 
  List<Object> get props => [];
}
class PopularTvseriesLoaded extends PopularTvseriesState {
  final List<Tvls> result;
  const PopularTvseriesLoaded(this.result);
  List<Object> get props => [result];
}
class PopularTvseriesError extends PopularTvseriesState {
  final String message;
  const PopularTvseriesError(this.message);  
  List<Object> get props => [message];
}
class PopularTvseriesLoading extends PopularTvseriesState {}
class PopularTvseriesEmpty extends PopularTvseriesState {}

class OnTheAirTvseriesState extends MainStateTv {
  const OnTheAirTvseriesState(); 
  List<Object> get props => [];
}
class OnTheAirTvseriesLoaded extends OnTheAirTvseriesState {
  final List<Tvls> result;
  const OnTheAirTvseriesLoaded(this.result);  
  List<Object> get props => [result];
}
class OnTheAirTvseriesError extends OnTheAirTvseriesState {
  final String message;
  const OnTheAirTvseriesError(this.message);
  List<Object> get props => [message];
}
class OnTheAirTvseriesLoading extends OnTheAirTvseriesState {}
class OnTheAirTvseriesEmpty extends OnTheAirTvseriesState {}

class TvseriesRecommendationsState extends MainStateTv{
  const TvseriesRecommendationsState(); 
  List<Object> get props => [];
}
class TvseriesRecommendationsLoaded extends TvseriesRecommendationsState {
  final List<Tvls> tvSeries;
  const TvseriesRecommendationsLoaded(this.tvSeries);  
  List<Object> get props => [tvSeries];
}
class TvseriesRecommendationsError extends TvseriesRecommendationsState {
  final String message;
  const TvseriesRecommendationsError(this.message);
  List<Object> get props => [message];
}
class TvseriesRecommendationsLoading extends TvseriesRecommendationsState {}
class TvseriesRecommendationsEmpty extends TvseriesRecommendationsState {}

class TopRatedTvseriesState extends MainStateTv{
  const TopRatedTvseriesState(); 
  List<Object> get props => [];
}
class TopRatedTvseriesLoaded extends TopRatedTvseriesState {
  final List<Tvls> result;
  const TopRatedTvseriesLoaded(this.result); 
  List<Object> get props => [result];
}
class TopRatedTvseriesError extends TopRatedTvseriesState {
  final String message;
  const TopRatedTvseriesError(this.message);
  List<Object> get props => [message];
}
class TopRatedTvseriesLoading extends TopRatedTvseriesState {}
class TopRatedTvseriesEmpty extends TopRatedTvseriesState {}

class TvseriesSearchState extends MainStateTv{
  const TvseriesSearchState();
  List<Object> get props => [];
}
class TvseriesSearchLoaded extends TvseriesSearchState {
  final List<Tvls> result;
  const TvseriesSearchLoaded(this.result);
  List<Object> get props => [result];
}
class TvseriesSearchError extends TvseriesSearchState {
  final String message;
  const TvseriesSearchError(this.message);
  List<Object> get props => [message];
}
class TvseriesSearchLoading extends TvseriesSearchState {}
class TvseriesSearchEmpty extends TvseriesSearchState {}

class TvseriesDetailState extends MainStateTv{
  const TvseriesDetailState();
  List<Object> get props => [];
}
class TvseriesDetailLoaded extends TvseriesDetailState {
  final TvlsDetail tvSeriesDetail;
  const TvseriesDetailLoaded(this.tvSeriesDetail);
  List<Object> get props => [tvSeriesDetail];
}
class TvseriesDetailError extends TvseriesDetailState {
  final String message;
  const TvseriesDetailError(this.message);
  List<Object> get props => [message];
}
class TvseriesDetailLoading extends TvseriesDetailState {}
class TvseriesDetailEmpty extends TvseriesDetailState {}


class WatchlistTvseriesState extends MainStateTv{
  const WatchlistTvseriesState();
  List<Object> get props => [];
}
class WatchlistTvseriesSuccess extends WatchlistTvseriesState {
  final String message;
  const WatchlistTvseriesSuccess(this.message);
  List<Object> get props => [message];
}
class WatchlistTvseriesError extends WatchlistTvseriesState {
  final String message;
  const WatchlistTvseriesError(this.message);
  List<Object> get props => [message];
}
class WatchlistTvseriesStatusLoaded extends WatchlistTvseriesState {
  final bool result;
  const WatchlistTvseriesStatusLoaded(this.result);
  List<Object> get props => [result];
}
class WatchlistTvseriesLoaded extends WatchlistTvseriesState {
  final List<Tvls> result;
  const WatchlistTvseriesLoaded(this.result);
  List<Object> get props => [result];
}
class WatchlistTvseriesLoading extends WatchlistTvseriesState {}
class WatchlistTvseriesEmpty extends WatchlistTvseriesState {}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinta_film/presentasi/halaman/template_tema.dart';
import 'package:cinta_film/presentasi/halaman/template_detail_halaman.dart';
import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:cinta_film/presentasi/bloc/tv_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvlsDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;
  TvlsDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvlsDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvseriesDetailBloc>()
             .add(TvseriesDetailGetEvent(widget.id));
      context.read<TvseriesRecommendationsBloc>()
             .add(TvseriesRecommendationsGetEvent(widget.id));
      context.read<WatchlistTvseriesBloc>()
             .add(WatchlistTvseriesGetStatusEvent(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    TvseriesRecommendationsState tvseriesRecommendations = context.watch<TvseriesRecommendationsBloc>().state;
    return Scaffold(
      body : BlocListener<WatchlistTvseriesBloc, WatchlistTvseriesState>(
        listener: (_, state) {
          if (state is WatchlistTvseriesSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
            context
                .read<WatchlistTvseriesBloc>()
                .add(WatchlistTvseriesGetStatusEvent(widget.id));
          }
        },
      child:  BlocBuilder<TvseriesDetailBloc, TvseriesDetailState>(
          builder: (context, state) {
            if (state is TvseriesDetailLoading) {
               return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
              } else if (state is TvseriesDetailLoaded) {
              final tv = state.tvSeriesDetail;
              bool isAddedToWatchlist = (context
                      .watch<WatchlistTvseriesBloc>()
                      .state is WatchlistTvseriesStatusLoaded)
                  ? (context.read<WatchlistTvseriesBloc>().state
                          as WatchlistTvseriesStatusLoaded)
                      .result
                  : false;
              return SafeArea(
                child: DetailContent(
                  tv,
                   tvseriesRecommendations is TvseriesRecommendationsLoaded
                      ? tvseriesRecommendations.tvSeries
                      : List.empty(),
                  isAddedToWatchlist,
                ),
              );
            } else {
              return Text("No Data Available");
          }
        },
      ),
    )
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvlsDetail tv;
  final List<Tvls> recommendations;
  final bool isAddedwatchlistTv;

  DetailContent(this.tv, this.recommendations, this.isAddedwatchlistTv);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => 
          Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedwatchlistTv) {
                                  BlocProvider.of<WatchlistTvseriesBloc>(
                                      context)
                                    ..add(WatchlistTvseriesTambahItemEvent(tv));
                                } else {
                                  BlocProvider.of<WatchlistTvseriesBloc>(
                                      context)
                                    ..add(WatchlistTvseriesHapusItemEvent(tv));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  isAddedwatchlistTv
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Daftar Tonton'),
                                ],
                              ),
                            ),
                            Text(
                              aliranFilm(tv.genres),
                            ),
                            Text(
                              (tv.firstAirDate),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tv.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Rekomendasi Serial TV',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvseriesRecommendationsBloc, TvseriesRecommendationsState>(
                              builder: (context, state) {
                                if (state is TvseriesRecommendationsLoading) {
                                    return Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(20),
                                      child: CircularProgressIndicator(),
                                    );
                                 } else if (state is TvseriesRecommendationsLoaded) {
                                  final recommendations = state.tvSeries;

                                  if (recommendations.isEmpty) {
                                    return const Text("Rekomendasi TV tidak Tersedia");
                                  }
                                  return Container(
                                      height: 150,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final tv = recommendations[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  TvlsDetailPage.ROUTE_NAME,
                                                  arguments: tv.id,
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                                  placeholder: (context, url) =>
                                                    Container(
                                                    alignment: Alignment.center,
                                                    padding: const EdgeInsets.all(20),
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: recommendations.length,
                                      ),
                                    );
                                  } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}

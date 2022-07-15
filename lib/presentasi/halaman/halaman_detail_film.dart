import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinta_film/presentasi/bloc/film_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinta_film/presentasi/halaman/template_tema.dart';
import 'package:cinta_film/presentasi/halaman/template_detail_halaman.dart';
import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/domain/entities/movie_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailPage extends StatefulWidget {
  
  static const ROUTE_NAME = '/detail';
  final int id;
  
  MovieDetailPage({required this.id});
  
  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();

}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask((){
      context.read<DetailFilmBloc>().add(
        GetEventDetailFilm(widget.id)
      );
      context.read<MovieRecommendationBloc>().add(
        GetMovieRecommendationEvent(widget.id)
      );
      context.read<DaftarTontonFilmBloc>().add(
        GetStatusMovieEvent(widget.id)
      );
    }
  );
 }

  @override
  Widget build(BuildContext context) {
    MovieRecommendationState movieRecommendations = context.watch<MovieRecommendationBloc>().state;
    return Scaffold(
      body: BlocListener<DaftarTontonFilmBloc, StateDaftarTontonFilm>(
        listener: (_, state) {
          if (state is MovieWatchlistSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              )
            );
            context.read<DaftarTontonFilmBloc>().add(GetStatusMovieEvent(widget.id));
          }
       },
       child:  BlocBuilder<DetailFilmBloc, StateDetailFilm>(
        builder: (context, provider) {
          if (provider is MovieDetailLoading) {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            );
          }else if(provider is MovieDetailLoaded){
            
            final film = provider.movieDetail;
            bool isAddedToWatchlist = (context.watch<DaftarTontonFilmBloc>().state is MovieWatchlistStatusLoaded) ? (context.read<DaftarTontonFilmBloc>().state as MovieWatchlistStatusLoaded).result : false;
        
            return SafeArea(
              child: DetailContent(
                film,
                movieRecommendations is MovieRecommendationLoaded ? movieRecommendations.movie : List.empty(),
                isAddedToWatchlist,
              ),
            );
            
          } else {
            return Text('Empty');
          }
         }
      ),
    )
  );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail film;
  final List<Film> recommendations;
  final bool isAddedwatchlist;

  DetailContent(this.film, this.recommendations, this.isAddedwatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${film.posterPath}',
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
                            film.title,
                            style: kHeading5,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (!isAddedwatchlist) {
                                BlocProvider.of<DaftarTontonFilmBloc>(context).add(AddItemMovieEvent(film));
                              } else {
                                BlocProvider.of<DaftarTontonFilmBloc>(context).add(RemoveItemMovieEvent(film));
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                (isAddedwatchlist != true) ? Icon(Icons.add) : Icon(Icons.check),
                                Text('Daftar Tonton'),
                              ],
                            ),
                          ),
                          Text(aliranFilm(film.genres)),
                          Text(fromatDurasi(film.runtime)),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: film.voteAverage / 2,
                                itemCount: 5,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: kMikadoYellow,
                                ),
                                itemSize: 24,
                              ),
                              Text('${film.voteAverage}')
                            ],
                          ),
                          SizedBox(height: 16),
                          Text('Overview', style: kHeading6),
                          Text(film.overview),
                          SizedBox(height: 16),
                          Text('Rekomendasi Film',style: kHeading6,),
                          BlocBuilder<MovieRecommendationBloc, MovieRecommendationState>(
                            builder: (context, data) {
                              if (data is MovieRecommendationLoading) {
                                return Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.only(top: 20),
                                  child: CircularProgressIndicator(),
                                );
                              }else if(data is MovieRecommendationError) {
                                return Text(data.message);
                              }else if(data is MovieRecommendationLoaded) {
                                return Container(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final film = recommendations[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context, 
                                              MovieDetailPage.ROUTE_NAME,
                                              arguments: film.id,
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:'https://image.tmdb.org/t/p/w500${film.posterPath}',
                                              placeholder: (context, url) => 
                                              Container(
                                                alignment: Alignment.center,
                                                padding: const EdgeInsets.all(20),
                                                child: CircularProgressIndicator(),
                                              ),
                                              errorWidget: (context, url, error) => 
                                              Icon(
                                                Icons.error
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                        },
                                        itemCount: recommendations.length,
                                      ),
                                    );
                              }else{
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

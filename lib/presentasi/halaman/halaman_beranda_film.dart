import 'package:cinta_film/presentasi/bloc/film_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinta_film/presentasi/halaman/drawer_kiri.dart';
import 'package:cinta_film/data/sumber_apis_data.dart';
import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/presentasi/halaman/halaman_detail_film.dart';
import 'package:cinta_film/presentasi/halaman/halaman_populer_film.dart';
import 'package:cinta_film/presentasi/halaman/halaman_pencarian_film.dart';
import 'package:cinta_film/presentasi/halaman/halaman_list_film_rating_terbaik.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:flutter_bloc/src/bloc_builder.dart";

class HomeMoviePage extends StatefulWidget {
  static const ROUTE_NAME = '/home';
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieNowPlayingBloc>().add(MovieNowPlayingGetEvent());
      context.read<MoviePopularBloc>().add(MoviePopularGetEvent());
      context.read<MovieTopRatedBloc>().add(MovieTopRatedGetEvent());
    });
  }

  final drawerFrame = ClassDrawerKiri();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerFrame.darwer(context),
      appBar: AppBar(
        title: Text('Cinta Film'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Film Saat Ini Tayang',
                textAlign: TextAlign.center,
              ),
              BlocBuilder<MovieNowPlayingBloc, MovieNowPlayingState>(
                builder: (context, state) {
                  if (state is MovieNowPlayingLoading){
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
                  }else if(state is MovieNowPlayingLoaded){
                    return MovieList(state.result);
                  }else if(state is MovieNowPlayingError){
                    return Text(state.message);
                  }else{
                    return Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              size: 45,
                              color: Colors.deepOrangeAccent,
                              ),
                              Text(' Gagal Memuat Data\r\n Periksa Koneksi Internet '),
                          ],
                        ),
                      ),
                    );
                  }
                }
              ),
              _buildSubHeading(
                title: 'Film Terpopuler',
                onTap: () => Navigator.pushNamed(
                  context, 
                  PopularMoviesPage.ROUTE_NAME
                ),
              ),
              BlocBuilder<MoviePopularBloc, MoviePopularState>(
                builder: (context, state) {
                  if(state is MovieNowPlayingLoading){
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
                  }else if(state is MoviePopularLoaded){
                    return MovieList(state.result);
                  }else if(state is MoviePopularError){
                    return Text(state.message);
                  }else{
                    return Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: 100,
                        child: 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.warning_amber_rounded,
                                size: 45,
                                color: Colors.deepOrangeAccent,
                              ),
                              Text('Gagal Memuat Data\r\n Periksa Koneksi Internet'),
                            ],

                          ),
                      ),
                    
                    );
                  }
                }
              ),
              _buildSubHeading(
                title: 'Film Dengan Rating Terbaik',
                onTap: () => Navigator.pushNamed(
                  context, 
                  TopRatedMoviesPage.ROUTE_NAME
                ),
              ),
              BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
                builder: (context, state) {
                  if (state is MovieTopRatedLoading) {
                     return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
                  }else if(state is MovieTopRatedLoaded){
                    return MovieList(state.result);
                  }else if(state is MovieTopRatedError) {
                    return Text(state.message);
                  }else{
                    return Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: 100,
                        child: 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.warning_amber_rounded,
                                size: 45,
                                color: Colors.deepOrangeAccent,
                              ),
                              Text(' Gagal Memuat Data\r\n Periksa Koneksi Internet '),
                            ],
                          )
                      ),
                    );
                  }
                }
              )
            ]
          )
        )
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('Lebih Banyak'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Film> film;

  MovieList(this.film);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final filmList = film[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: filmList.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${filmList.posterPath}',
                  placeholder: (context, url) => 
                     Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: film.length,
      ),
    );
  }
}

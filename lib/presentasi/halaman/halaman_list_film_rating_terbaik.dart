import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinta_film/presentasi/widgets/card_list.dart';
import 'package:cinta_film/presentasi/bloc/film_bloc.dart';
import 'package:flutter/material.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-film';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieTopRatedBloc>().add(MovieTopRatedGetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Film'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
         child: BlocBuilder<MovieTopRatedBloc, MovieTopRatedState>(
           builder: (context, state) {
            if (state is MovieTopRatedLoading) {
                 return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
            } else if (state is MovieTopRatedLoaded){
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final film = state.result[index];
                    return CardList.film(film, 'widgetFilm');
                  },
                  itemCount: state.result.length,
                );
            } else {
                return Center(
                  key: Key('error_message'),
                  child: Text('Error Data Fecth'),
                );
            }
          },
        ),
      ),
    );
  }
}

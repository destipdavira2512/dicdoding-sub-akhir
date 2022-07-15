import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinta_film/presentasi/widgets/card_list.dart';
import 'package:cinta_film/presentasi/bloc/film_bloc.dart';
import 'package:flutter/material.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-film';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MoviePopularBloc>().add(MoviePopularGetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Film'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MoviePopularBloc, MoviePopularState>(
          builder: (context, state) {
            if(state is MoviePopularLoading){
                 return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
              }else if(state is MoviePopularLoaded){
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final film = state.result[index];
                    return CardList.film(film, 'widgetFilm');
                  },
                  itemCount: state.result.length,
                );
              }else{
                return Center(
                  key: Key('error_message'),
                  child: Text("Error"),
                );
              }
            },
          ),
        ),
      );
    }
  }

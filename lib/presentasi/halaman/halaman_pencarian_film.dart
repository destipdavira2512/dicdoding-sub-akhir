import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinta_film/presentasi/bloc/film_bloc.dart';
import 'package:cinta_film/presentasi/widgets/card_list.dart';
import 'package:flutter/material.dart';


class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  @override
  Widget build(BuildContext context) {
    var cari = false;
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                cari = true;
                 context
                    .read<MovieSearchBloc>()
                    .add(MovieSearchQueryEvent(query));
              },
              decoration: InputDecoration(
                hintText: 'Cari Film Disini',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            BlocBuilder<MovieSearchBloc, MovieSearchState>(
              builder: (context, data) {
                if (data is MovieSearchLoading) {
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
                 } else if (data is MovieSearchLoaded) {
                    final result = data.result;
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final film = data.result[index];
                          return CardList.film(film, 'widgetFilm');
                        },
                        itemCount: result.length,
                      ),
                    );
                  } else {
                    if (cari) {
                      return Center(
                        child: Text(
                          'Upss..Maaf Film Belum Tersedia',
                          style:
                              TextStyle(fontSize: 20, color: Colors.blueAccent),
                        ),
                      );
                    } else {
                      return Center();
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

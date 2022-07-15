import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinta_film/presentasi/bloc/tv_bloc.dart';
import 'package:cinta_film/presentasi/widgets/card_list.dart';

class SearchTvlsPage extends StatelessWidget {
  static const ROUTE_NAME = '/pencarian-tv';

  @override
  Widget build(BuildContext context) {
    var cari = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menu Pencarian',
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                cari = true;
                context.read<TvseriesSearchBloc>()
                       .add(TvseriesSearchQueryEvent(query));
              },
              decoration: InputDecoration(
                hintText: 'Cari Serial Tv Disini',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            BlocBuilder<TvseriesSearchBloc, TvseriesSearchState>(
              builder: (context, state) {
                if (state is TvseriesSearchLoading) {
                     return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
                 } else if (state is TvseriesSearchLoaded) {
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final tv = state.result[index];
                          return CardList.tv(tv, 'widgetTv');
                        },
                        itemCount: state.result.length,
                      ),
                    );
                 } else {
                    if (cari) {
                      cari = false;
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

import 'package:cinta_film/presentasi/bloc/tv_bloc.dart';
import 'package:cinta_film/presentasi/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HalamanSerialTvTerbaik extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  @override
  _TopRatedTvPageState createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<HalamanSerialTvTerbaik> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TopRatedTvseriesBloc>().add(TopRatedTvseriesGetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Serial Tv Ranting Tertinggi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvseriesBloc, TopRatedTvseriesState>(
          builder: (context, state) {
            if (state is TopRatedTvseriesLoading) {
                 return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
               } else if (state is TopRatedTvseriesLoaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tv = state.result[index];
                    return CardList.tv(tv, 'widgetTv');
                  },
                  itemCount: state.result.length,
                );
               }else{
                return Center(
                  key: Key('error_message'),
                  child: Text("Failed Fecth Data"),
                );
            }
          },
        ),
      ),
    );
  }
}

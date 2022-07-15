import 'package:cinta_film/presentasi/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinta_film/presentasi/bloc/tv_bloc.dart';

class PopularTvlsPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopularTvPageState createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvlsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PopularTvseriesBloc>().add(PopularTvseriesGetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child:BlocBuilder<PopularTvseriesBloc, PopularTvseriesState>(
          builder: (context, state) {
            if (state is PopularTvseriesLoading) {
                 return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
                } else if (state is PopularTvseriesLoaded) {
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
                  child: Text("Failed Fetch Data"),
                );
            }
          },
        ),
      ),
    );
  }
}

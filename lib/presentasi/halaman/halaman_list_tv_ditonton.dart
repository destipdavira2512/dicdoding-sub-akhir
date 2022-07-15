import 'package:cinta_film/presentasi/halaman/template_detail_halaman.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinta_film/presentasi/bloc/tv_bloc.dart';
import 'package:cinta_film/presentasi/widgets/card_list.dart';
import 'package:flutter/material.dart';

class ClassHalamanListSerialTv extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';

  @override
  _WatchlistTvPageState createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<ClassHalamanListSerialTv>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistTvseriesBloc>().add(WatchlistTvseriesGetEvent());
    });
  }

 void didPopNext() {
    context.read<WatchlistTvseriesBloc>().add(WatchlistTvseriesGetEvent());
 }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tonnton TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvseriesBloc, WatchlistTvseriesState>(
          builder: (context, data) {
            if (data is WatchlistTvseriesLoading) {
                return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
               } else if (data is WatchlistTvseriesLoaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tv = data.result[index];
                    return CardList.tv(tv, 'widgetTv');
                  },
                  itemCount: data.result.length,
                );
               } else {
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

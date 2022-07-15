import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinta_film/data/sumber_apis_data.dart';
import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:cinta_film/presentasi/halaman/drawer_kiri.dart';
import 'package:cinta_film/presentasi/halaman/halaman_populer_tv.dart';
import 'package:cinta_film/presentasi/halaman/halaman_pencarian_tv.dart';
import 'package:cinta_film/presentasi/halaman/halaman_list_tv_rating_terbaik.dart';
import 'package:cinta_film/presentasi/halaman/halaman_detail_tv.dart';
import 'package:cinta_film/presentasi/bloc/tv_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class HomeTvlsPage extends StatefulWidget {
  @override
  _HomeTvlsPageState createState() => _HomeTvlsPageState();
  static const ROUTE_NAME = '/tv';
}

class _HomeTvlsPageState extends State<HomeTvlsPage> {
  @override
  void initState() {
    super.initState();
     Future.microtask(() {
      context.read<OnTheAirTvseriesBloc>().add(OnTheAirTvseriesGetEvent());
      context.read<PopularTvseriesBloc>().add(PopularTvseriesGetEvent());
      context.read<TopRatedTvseriesBloc>().add(TopRatedTvseriesGetEvent());
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
              Navigator.pushNamed(context, SearchTvlsPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Serial TV Sedang Tayang',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              BlocBuilder<OnTheAirTvseriesBloc, OnTheAirTvseriesState>(
                builder: (context, data) {
                  if (data is OnTheAirTvseriesLoading) {
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
                  } else if (data is OnTheAirTvseriesLoaded) {
                    return TvList(data.result);
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
                            Text(
                                ' Gagal Memuat Data\r\n Periksa Koneksi Internet '),
                          ],
                        ),
                      ),
                    );
                }
              }),
              _buildSubHeading(
                title: 'Serial TV Terpopuler',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvlsPage.ROUTE_NAME),
              ),
               BlocBuilder<PopularTvseriesBloc, PopularTvseriesState>(
                builder: (context, state) {
                  if (state is PopularTvseriesLoading) {
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularTvseriesLoaded) {
                    return TvList(state.result);
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
                            Text(
                                ' Gagal Memuat Data\r\n Periksa Koneksi Internet '),
                          ],
                        ),
                      ),
                    );
                }
              }),
              _buildSubHeading(
                title: 'Serial TV Rating Terbaik',
                onTap: () => Navigator.pushNamed(
                    context, HalamanSerialTvTerbaik.ROUTE_NAME),
              ),
               BlocBuilder<TopRatedTvseriesBloc, TopRatedTvseriesState>(
                builder: (context, state) {
                  if (state is TopRatedTvseriesLoading) {
                    return Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    );
                   } else if (state is TopRatedTvseriesLoaded) {
                    return TvList(state.result);
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
                            Text(
                                ' Gagal Memuat Data\r\n Periksa Koneksi Internet '),
                          ],
                        ),
                      ),
                    );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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

class TvList extends StatelessWidget {
  final List<Tvls> tv;

  TvList(this.tv);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvs = tv[index];
          return Container(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvlsDetailPage.ROUTE_NAME,
                  arguments: tvs.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvs.posterPath}',
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
        itemCount: tv.length,
      ),
    );
  }
}

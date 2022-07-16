import 'dart:async';
import 'data/ssl_pinning.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cinta_film/injection.dart' as inject;
import 'package:cinta_film/presentasi/halaman/template_detail_halaman.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:cinta_film/presentasi/halaman/nav_bar_bawah.dart';
import 'package:cinta_film/presentasi/halaman/halaman_detail_tv.dart';
import 'package:cinta_film/presentasi/halaman/halaman_populer_tv.dart';
import 'package:cinta_film/presentasi/halaman/halaman_beranda_tv.dart';
import 'package:cinta_film/presentasi/halaman/halaman_detail_film.dart';
import 'package:cinta_film/presentasi/halaman/halaman_tentang_kami.dart';
import 'package:cinta_film/presentasi/halaman/halaman_beranda_film.dart';
import 'package:cinta_film/presentasi/halaman/halaman_populer_film.dart';
import 'package:cinta_film/presentasi/halaman/halaman_pencarian_tv.dart';
import 'package:cinta_film/presentasi/halaman/halaman_pencarian_film.dart';
import 'package:cinta_film/presentasi/halaman/halaman_list_tv_ditonton.dart';
import 'package:cinta_film/presentasi/halaman/halaman_list_film_ditonton.dart';
import 'package:cinta_film/presentasi/halaman/halaman_list_tv_rating_terbaik.dart';
import 'package:cinta_film/presentasi/halaman/halaman_list_film_rating_terbaik.dart';
import 'package:cinta_film/presentasi/bloc/tv_bloc.dart';
import 'package:cinta_film/presentasi/bloc/film_bloc.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await ClassSSLPinning.init();
    await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    inject.init();

    runApp(MyApp());
  },
      (error, stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => inject.locator<DetailFilmBloc>(),
        ),
        BlocProvider(
          create: (_) => inject.locator<MoviePopularBloc>(),
        ),
        BlocProvider(
          create: (_) => inject.locator<MovieRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => inject.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => inject.locator<MovieTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => inject.locator<MovieNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => inject.locator<DaftarTontonFilmBloc>(),
        ),
        BlocProvider(
          create: (_) => inject.locator<TvseriesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => inject.locator<TvseriesRecommendationsBloc>(),
        ),
        BlocProvider(
          create: (_) => inject.locator<TvseriesSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => inject.locator<PopularTvseriesBloc>(),
        ),
        BlocProvider(
          create: (_) => inject.locator<TopRatedTvseriesBloc>(),
        ),
        BlocProvider(
          create: (_) => inject.locator<OnTheAirTvseriesBloc>(),
        ),
        BlocProvider(
          create: (_) => inject.locator<WatchlistTvseriesBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Cinta Film',
        theme: ThemeData.fallback(),
        home: BottomBar(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case '/tv':
              return MaterialPageRoute(builder: (_) => HomeTvlsPage());
            case PopularTvlsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvlsPage());
            case HalamanSerialTvTerbaik.ROUTE_NAME:
              return CupertinoPageRoute(
                  builder: (_) => HalamanSerialTvTerbaik());
            case TvlsDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvlsDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case SearchTvlsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTvlsPage());
            case ClassHalamanDaftarTontonFilm.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => ClassHalamanDaftarTontonFilm());
            case ClassHalamanListSerialTv.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => ClassHalamanListSerialTv());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}

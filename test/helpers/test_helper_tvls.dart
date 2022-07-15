import 'package:cinta_film/data/lib_database.dart';
import 'package:cinta_film/data/datasources/tvls/tvls_local_data_source.dart';
import 'package:cinta_film/data/datasources/tvls/tvls_remote_data_source.dart';
import 'package:cinta_film/data/lib_server_fail.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:cinta_film/domain/get_data_tv.dart';
import 'package:cinta_film/presentasi/bloc/tv_bloc.dart';

@GenerateMocks([
  TvlsRepository,
  TvlsRemoteDataSource,
  TvlsLocalDataSource,
  DatabaseHelperTvls,
  WatchlistTvseriesBloc,
  TvseriesDetailBloc,
  TvseriesSearchBloc,
  TopRatedTvseriesBloc,
  TvseriesRecommendationsBloc,
  OnTheAirTvseriesBloc,
  PopularTvseriesBloc,
  GetserialTvSaatIniDiPutarls,
  GetPopularTvls,
  GetTopRatedTvls,
  GetTvlsDetail,
  GetTvlsRecommendations,
  ClassStatusDaftarTontonTvls,
  GetwatchlistTvls,
  ClassHapusDaftarTontonTvls,
  ClassSimpanDaftarTontonTvls,
  SearchTvls
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

import 'package:dartz/dartz.dart';
import 'package:cinta_film/domain/entities/tvls/tvls.dart';
import 'package:cinta_film/domain/get_data_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../test/dummy_data/dummy_objects_tvls.dart';
import '../../test/helpers/test_helper_tvls.mocks.dart';

void main() {
  late SearchTvls usecase;
  late ClassSimpanDaftarTontonTvls usecase1;
  late ClassHapusDaftarTontonTvls usecase2;
  late GetwatchlistTvls usecase3;
  late ClassStatusDaftarTontonTvls usecase4;
  late GetTvlsRecommendations usecase5;
  late GetTvlsDetail usecase6;
  late GetTopRatedTvls usecase7;
  late GetPopularTvls usecase8;
  late GetserialTvSaatIniDiPutarls usecase9;
  late MockTvlsRepository mockTvRepository;

  setUp(() {
    mockTvRepository  = MockTvlsRepository();
    usecase           = SearchTvls(mockTvRepository);
    usecase1          = ClassSimpanDaftarTontonTvls(mockTvRepository);
    usecase2          = ClassHapusDaftarTontonTvls(mockTvRepository);
    usecase3          = GetwatchlistTvls(mockTvRepository);
    usecase4          = ClassStatusDaftarTontonTvls(mockTvRepository);
    usecase5          = GetTvlsRecommendations(mockTvRepository);
    usecase6          = GetTvlsDetail(mockTvRepository);
    usecase7          = GetTopRatedTvls(mockTvRepository);
    usecase8          = GetPopularTvls(mockTvRepository);
    usecase9          = GetserialTvSaatIniDiPutarls(mockTvRepository);
  });

  final tTv     = <Tvls>[];
  final tQuery  = 'Game of throne';
  final tId     = 1;

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockTvRepository.searchTv(tQuery)).thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTv));
  });
  
  test('should save tv to the repository', () async {
    // arrange
    when(mockTvRepository.savewatchlistTv(testTvDetail))
        .thenAnswer((_) async => Right('Added to watchlist'));
    // act
    final result = await usecase1.execute(testTvDetail);
    // assert
    verify(mockTvRepository.savewatchlistTv(testTvDetail));
    expect(result, Right('Added to watchlist'));
  });

  test('should remove watchlist tv from repository', () async {
    // arrange
    when(mockTvRepository.removewatchlistTv(testTvDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase2.execute(testTvDetail);
    // assert
    verify(mockTvRepository.removewatchlistTv(testTvDetail));
    expect(result, Right('Removed from watchlist'));
  });

  test('should get list of tv series from the repository', () async {
    // arrange
    when(mockTvRepository.getwatchlistTv())
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase3.execute();
    // assert
    expect(result, Right(testTvList));
  });

  test('should get watchlist tv status from repository', () async {
    // arrange
    when(mockTvRepository.isAddedTowatchlistTv(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase4.execute(1);
    // assert
    expect(result, true);
  });

  test('should get list of tv recommendations from the repository', () async {
    // arrange
    when(mockTvRepository.getTvRecommendations(tId))
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase5.execute(tId);
    // assert
    expect(result, Right(tTv));
  });

  test('should get tv detail from the repository', () async {
    // arrange
    when(mockTvRepository.getTvDetail(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    // act
    final result = await usecase6.execute(tId);
    // assert
    expect(result, Right(testTvDetail));
  });

  test('should get list of tv from repository', () async {
    // arrange
    when(mockTvRepository.getTopRatedTv()).thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase7.execute();
    // assert
    expect(result, Right(tTv));
  });

  group('Get Popular Tv Tests', () {
    group('execute', () {
      test(
          'should get list of tv from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvRepository.getPopularTv())
            .thenAnswer((_) async => Right(tTv));
        // act
        final result = await usecase8.execute();
        // assert
        expect(result, Right(tTv));
      });
    });
  });

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockTvRepository.getserialTvSaatIniDiPutar())
        .thenAnswer((_) async => Right(tTv));
    // act
    final result = await usecase9.execute();
    // assert
    expect(result, Right(tTv));
  });

}

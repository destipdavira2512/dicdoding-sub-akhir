import 'package:dartz/dartz.dart';
import 'package:cinta_film/domain/entities/film.dart';
import 'package:cinta_film/domain/get_data_film.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../test/dummy_data/dummy_objects.dart';
import '../../test/helpers/test_helper.mocks.dart';
void main() {
  late ClassCariFilm usecase;
  late ClassSimpanDaftarTonton usecase2;
  late ClassHapusDaftarTonton usecase3;
  late ClassStatusDaftarTonton usecase4;
  late ClassDaftarTontonFilm usecase5;
  late ClassFilmRatingTerbaik usecase6;
  late ClasFilmTayangSaatIni usecase7;
  late AmbilDataRekomendasiFilm usecase8;
  late AmbilDataDetailFilm usecase9;
  late ClassFilmTerPopuler usecase10;
  late MockRepositoryFilm mockRepositoryFilm;

  final tMovies = <Film>[];
  final tQuery  = 'Spiderman';
  final tId     = 1;
  final tId2    = 1;

  setUp(() {
    mockRepositoryFilm = MockRepositoryFilm();
    usecase            = ClassCariFilm(mockRepositoryFilm);
    usecase2           = ClassSimpanDaftarTonton(mockRepositoryFilm);
    usecase3           = ClassHapusDaftarTonton(mockRepositoryFilm);
    usecase4           = ClassStatusDaftarTonton(mockRepositoryFilm);
    usecase5           = ClassDaftarTontonFilm(mockRepositoryFilm);
    usecase6           = ClassFilmRatingTerbaik(mockRepositoryFilm);
    usecase7           = ClasFilmTayangSaatIni(mockRepositoryFilm);
    usecase8           = AmbilDataRekomendasiFilm(mockRepositoryFilm);
    usecase9           = AmbilDataDetailFilm(mockRepositoryFilm);
    usecase10          = ClassFilmTerPopuler(mockRepositoryFilm);
  });


  test('should get list of Film from the repository', () async {
    when(mockRepositoryFilm.cariFilm(tQuery))
        .thenAnswer((_) async => Right(tMovies));
    final result = await usecase.execute(tQuery);
    expect(result, Right(tMovies));
  });

  test('should save film to the repository', () async {
    // arrange
    when(mockRepositoryFilm.daftarTonton(testMovieDetail))
        .thenAnswer((_) async => Right('Added to watchlist'));
    // act
    final result = await usecase2.execute(testMovieDetail);
    // assert
    verify(mockRepositoryFilm.daftarTonton(testMovieDetail));
    expect(result, Right('Added to watchlist'));
  });

  test('should remove watchlist film from repository', () async {
    // arrange
    when(mockRepositoryFilm.removewatchlist(testMovieDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase3.execute(testMovieDetail);
    // assert
    verify(mockRepositoryFilm.removewatchlist(testMovieDetail));
    expect(result, Right('Removed from watchlist'));
  });

  test('should get watchlist status from repository', () async {
    // arrange
    when(mockRepositoryFilm.isAddedTowatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase4.execute(1);
    // assert
    expect(result, true);
  });

  test('should get watchlist of Film from the repository', () async {
    // arrange
    when(mockRepositoryFilm.ambilDaftarTontonFilm())
        .thenAnswer((_) async => Right(testMovieList));
    // act
    final result = await usecase5.execute();
    // assert
    expect(result, Right(testMovieList));
  });
 
  test('should get toprated list of Film from repository', () async {
    // arrange
    when(mockRepositoryFilm.ambilFilmRatingTerbaik())
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase6.execute();
    // assert
    expect(result, Right(tMovies));
  });

  test('should get nowplaying list of Film from the repository', () async {
    // arrange
    when(mockRepositoryFilm.filmTayangSaatIni())
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase7.execute();
    // assert
    expect(result, Right(tMovies));
  });

  test('should get list of film recommendations from the repository', () async {
    // arrange
    when(mockRepositoryFilm.getMovieRecommendations(tId))
        .thenAnswer((_) async => Right(tMovies));
    // act
    final result = await usecase8.execute(tId);
    // assert
    expect(result, Right(tMovies));
  });

  test('should get film detail from the repository', () async {
    // arrange
    when(mockRepositoryFilm.getMovieDetail(tId2))
        .thenAnswer((_) async => Right(testMovieDetail));
    // act
    final result = await usecase9.execute(tId2);
    // assert
    expect(result, Right(testMovieDetail));
  });

  group('ClassFilmTerPopuler Tests', () {
    group('execute', () {
      test(
          'should get list of Film from the repository when execute function is called',
          () async {
        // arrange
        when(mockRepositoryFilm.ambilDataFilmTerPopuler())
            .thenAnswer((_) async => Right(tMovies));
        // act
        final result = await usecase10.execute();
        // assert
        expect(result, Right(tMovies));
      });
    });
  });

}

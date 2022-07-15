import 'dart:async';
import 'package:cinta_film/data/models/tvls/tvls_table.dart';
import 'package:cinta_film/data/models/movie_table.dart';
import 'package:sqflite/sqflite.dart';

const String _tblwatchlisttvls  = 'watchlisttv';
const String _tblwatchlist      = 'watchlist';

class DatabaseHelperTvls {
  static DatabaseHelperTvls? _databaseHelpertvls;
  static Database? _databasetvls;
  factory DatabaseHelperTvls() => _databaseHelpertvls ?? DatabaseHelperTvls._instance();

  DatabaseHelperTvls._instance() {_databaseHelpertvls = this;}

  Future<Database?> get databasetvls async {
    if (_databasetvls == null) {
      _databasetvls = await _initDb();
    }
    return _databasetvls;
  }

  Future<Database> _initDb() async {
    final path          = await getDatabasesPath();
    final databasePath  = '$path/cinta_filmtvs.db';
    var db              = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblwatchlisttvls (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertwatchlistTv(TvlsTable tv) async {
    final db = await databasetvls;
    return await db!.insert(_tblwatchlisttvls, tv.toJson());
  }

  Future<int> removewatchlistTv(TvlsTable tv) async {
    final db = await databasetvls;
    return await db!.delete(
      _tblwatchlisttvls,
      where: 'id = ?',
      whereArgs: [tv.id],
    );
  }

  Future<Map<String, dynamic>?> getTvById(int id) async {
    final db = await databasetvls;
    final results = await db!.query(
      _tblwatchlisttvls,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getwatchlistTv() async {
    final db = await databasetvls;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblwatchlisttvls);

    return results;
  }
}

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

 

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/cinta_film.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblwatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertwatchlist(MovieTable film) async {
    final db = await database;
    return await db!.insert(_tblwatchlist, film.toJson());
  }

  Future<int> removewatchlist(MovieTable film) async {
    final db = await database;
    return await db!.delete(
      _tblwatchlist,
      where: 'id = ?',
      whereArgs: [film.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblwatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> ambilDaftarTontonFilm() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblwatchlist);

    return results;
  }
}

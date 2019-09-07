import 'dart:io';
import 'dart:math';

import 'package:cocktailr/src/bases/cocktail_cache.dart';
import 'package:cocktailr/src/bases/cocktail_source.dart';
import 'package:cocktailr/src/models/cocktail.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class CocktailDbSqflite implements CocktailSource, CocktailCache {
  Database db;

  CocktailDbSqflite() {
    init();
  }

  Future<void> init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "cocktails.db");

    db = await openDatabase(path, version: 1, onCreate: (
      Database newDb,
      int version,
    ) {
      newDb.execute("""
          CREATE TABLE Cocktails
            (
              id TEXT PRIMARY KEY,
              name TEXT,
              category TEXT,
              instructions TEXT,
              image TEXT,
              isAlcoholic INTEGER,
              ingredients BLOB,
              measurements BLOB
            )
        """);
    });
  }

  Future<Cocktail> fetchCocktailById(String cocktailId) async {
    if (db == null) await init();

    try {
      final maps = await db.query(
        "Cocktails",
        columns: null,
        where: "id = ?",
        whereArgs: [cocktailId],
      );

      if (maps.length > 0) {
        return Cocktail.fromDb(maps.first);
      }

      return null;
    } catch (e) {
      print('Error while fetching cocktail by id from sqflite db: $e');
      return null;
    }
  }

  Future<Cocktail> fetchRandomCocktail() async {
    if (db == null) await init();

    try {
      final maps = await db.query(
        "Cocktails",
        columns: null,
      );

      if (maps.length > 0) {
        final index = Random().nextInt(maps.length);
        return Cocktail.fromDb(maps[index]);
      }

      return null;
    } catch (e) {
      print('Error while fetching random cocktail from sqflite db: $e');
      return null;
    }
  }

  Future<List<String>> fetchCocktailIdsByIngredient(String ingredient) async {
    if (db == null) await init();

    try {
      final maps = await db.query(
        "Cocktails",
        columns: null,
      );

      if (maps.length > 0) {
        return maps
            .map((c) => Cocktail.fromDb(c))
            .where((c) => c.ingredients.contains(ingredient))
            .map((c) => c.id)
            .toList();
      }

      return null;
    } catch (e) {
      print('Error while fetching cocktailids by ingredient from sqflite db: $e');
      return [];
    }
  }

  Future<int> insertCocktail(Cocktail cocktail) {
    return db.insert(
      "Cocktails",
      cocktail.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

final cocktailDbSqflite = CocktailDbSqflite();

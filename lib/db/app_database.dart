import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// Импортируй файл с таблицей, в котором класс называется Characters
import 'package:rick_and_morty/db/tables/character_table.dart';
import 'package:rick_and_morty/db/tables/settings_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Characters, Settings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> insertOrUpdateCharacters(List<CharactersCompanion> charactersList) async {
    batch((batch) {
      batch.insertAllOnConflictUpdate(characters, charactersList);
    });
  }

  Future<List<Character>> getAllCharacters() => select(characters).get();

  Future<List<Character>> getFavoriteCharacters() =>
      (select(characters)..where((tbl) => tbl.isFavorite.equals(true))).get();

  Future<void> toggleFavorite(int id, bool isFav) async {
    await (update(characters)..where((tbl) => tbl.id.equals(id))).write(
      CharactersCompanion(isFavorite: Value(isFav)),
    );
  }

  Future<void> saveTheme(String themeMode) async {
    await into(settings).insertOnConflictUpdate(
      SettingsCompanion.insert(key: 'theme', value: themeMode),
    );
  }

  Future<String?> getSavedTheme() async {
    final result = await (select(settings)..where((tbl) => tbl.key.equals('theme'))).getSingleOrNull();
    return result?.value;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));
    return NativeDatabase(file);
  });
}

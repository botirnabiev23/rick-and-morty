import 'package:drift/drift.dart';
import 'package:rick_and_morty/db/app_database.dart';
import 'package:rick_and_morty/features/character/data/models/character_model.dart';

class CharacterLocalDataSource {
  final AppDatabase db;

  CharacterLocalDataSource(this.db);

  Future<void> cacheCharacters(List<CharacterModel> characters) async {
    final entries = characters.map((c) => CharactersCompanion(
      id: Value(c.id),
      name: Value(c.name),
      status: Value(c.status),
      image: Value(c.image),
      isFavorite: Value(false),
    )).toList();

    await db.insertOrUpdateCharacters(entries);
  }

  Future<List<CharacterModel>> getAllCharacters() async {
    final rows = await db.getAllCharacters();
    return rows.map((e) => CharacterModel.fromDrift(e)).toList();
  }

  Future<List<CharacterModel>> getFavorites() async {
    final rows = await db.getFavoriteCharacters();
    return rows.map((e) => CharacterModel.fromDrift(e)).toList();
  }

  Future<void> toggleFavorite(int id, bool isFav) {
    return db.toggleFavorite(id, isFav);
  }
}

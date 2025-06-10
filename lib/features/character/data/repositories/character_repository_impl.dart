import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/db/app_database.dart';
import 'package:rick_and_morty/features/character/data/models/character_model.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/character_entity.dart';
import '../../domain/repositories/character_repository.dart';
import '../data_sources/character_remote_data_source.dart';

@LazySingleton(as: CharacterRepository)
class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;
  final AppDatabase db;

  CharacterRepositoryImpl(this.remoteDataSource, this.db);

  @override
  Future<Either<Failure, List<CharacterEntity>>> getCharacters() async {
    try {
      final result = await remoteDataSource.getCharacters();

      final cachedFavorites = await db.getFavoriteCharacters();
      final favoriteIds = cachedFavorites.map((e) => e.id).toSet();

      final charactersWithFavorites =
          result.map((model) {
            return model.copyWith(isFavorite: favoriteIds.contains(model.id));
          }).toList();

      final charactersCompanions =
          charactersWithFavorites
              .map((e) => CharacterModel.fromEntity(e).toDrift())
              .toList();
      await db.insertOrUpdateCharacters(charactersCompanions);

      return Right(charactersWithFavorites);
    } catch (e) {
      try {
        final cachedCharacters = await db.getAllCharacters();
        final models =
            cachedCharacters.map((c) => CharacterModel.fromDrift(c)).toList();
        return Right(models);
      } catch (_) {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> addToFavorites(int characterId) async {
    try {
      await db.toggleFavorite(characterId, true);
      return const Right(null);
    } catch (_) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavorites(int characterId) async {
    try {
      await db.toggleFavorite(characterId, false);
      return const Right(null);
    } catch (_) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<int>>> getFavoriteCharacterIds() async {
    try {
      final favorite = await db.getFavoriteCharacters();
      return Right(favorite.map((e) => e.id).toList());
    } catch (_) {
      return Left(CacheFailure());
    }
  }
}

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/character_entity.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<CharacterEntity>>> getCharacters();

  Future<Either<Failure, List<int>>> getFavoriteCharacterIds();

  Future<Either<Failure, void>> addToFavorites(int characterId);

  Future<Either<Failure, void>> removeFromFavorites(int characterId);
}

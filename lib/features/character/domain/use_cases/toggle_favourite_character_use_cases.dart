import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/core/errors/failure.dart';
import '../../domain/entities/character_entity.dart';
import '../../domain/repositories/character_repository.dart';

@injectable
class ToggleFavoriteCharacterUseCase {
  final CharacterRepository repository;

  ToggleFavoriteCharacterUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required int characterId,
    required bool isFavorite,
  }) async {
    if (isFavorite) {
      return await repository.addToFavorites(characterId);
    } else {
      return await repository.removeFromFavorites(characterId);
    }
  }
}


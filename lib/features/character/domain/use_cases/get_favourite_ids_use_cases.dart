import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/core/errors/failure.dart';

import '../../domain/repositories/character_repository.dart';

@injectable
class GetFavoriteCharacterIdsUseCase {
  final CharacterRepository repository;

  GetFavoriteCharacterIdsUseCase(this.repository);

  Future<Either<Failure, List<int>>> call() {
    return repository.getFavoriteCharacterIds();
  }
}


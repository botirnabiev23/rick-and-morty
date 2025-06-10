import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/core/errors/failure.dart';
import '../entities/character_entity.dart';
import '../repositories/character_repository.dart';
import 'package:dartz/dartz.dart';


@lazySingleton
class GetCharactersUseCase {
  final CharacterRepository repository;

  GetCharactersUseCase(this.repository);

  Future<Either<Failure, List<CharacterEntity>>> call() {
    return repository.getCharacters();
  }
}

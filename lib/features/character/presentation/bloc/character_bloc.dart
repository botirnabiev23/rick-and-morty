import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/features/character/domain/entities/character_entity.dart';
import 'package:rick_and_morty/features/character/domain/use_cases/get_characters_use_case.dart';
import 'package:rick_and_morty/features/character/domain/use_cases/get_favourite_ids_use_cases.dart';
import 'package:rick_and_morty/features/character/domain/use_cases/toggle_favourite_character_use_cases.dart';
import 'package:rick_and_morty/core/errors/failure.dart';

part 'character_event.dart';

part 'character_state.dart';

part 'character_bloc.freezed.dart';

@injectable
class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final GetCharactersUseCase getAllCharacters;
  final GetFavoriteCharacterIdsUseCase getFavoriteIds;
  final ToggleFavoriteCharacterUseCase toggleFavorite;

  CharacterBloc({
    required this.getAllCharacters,
    required this.getFavoriteIds,
    required this.toggleFavorite,
  }) : super(const CharacterState.initial()) {
    on<_LoadCharacters>(_onLoadCharacters);
    on<_ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadCharacters(
    _LoadCharacters event,
    Emitter<CharacterState> emit,
  ) async {
    emit(const CharacterState.loading());

    final charactersResult = await getAllCharacters();
    final favoriteIdsResult = await getFavoriteIds();

    charactersResult.fold(
      (failure) {
        emit(CharacterState.error(_mapFailureToMessage(failure)));
      },
      (characters) {
        favoriteIdsResult.fold(
          (failure) {
            emit(CharacterState.error(_mapFailureToMessage(failure)));
          },
          (favoriteIds) {
            final updatedCharacters =
                characters.map((character) {
                  return character.copyWith(
                    isFavorite: favoriteIds.contains(character.id),
                  );
                }).toList();

            emit(CharacterState.loaded(characters: updatedCharacters));
          },
        );
      },
    );
  }

  Future<void> _onToggleFavorite(
    _ToggleFavorite event,
    Emitter<CharacterState> emit,
  ) async {
    final currentState = state;

    if (currentState is CharactersLoaded) {
      final wasFavorite = event.character.isFavorite;
      final newFavoriteStatus = !wasFavorite;

      final result = await toggleFavorite(
        characterId: event.character.id,
        isFavorite: newFavoriteStatus,
      );

      result.fold((failure) {}, (_) {
        final updatedCharacters =
            currentState.characters.map((character) {
              if (character.id == event.character.id) {
                return character.copyWith(isFavorite: newFavoriteStatus);
              }
              return character;
            }).toList();

        emit(CharacterState.loaded(characters: updatedCharacters));
      });
    }
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure)
      return 'Server error. Please try again later.';
    if (failure is CacheFailure) return 'Cache error. Try again.';
    return 'Unexpected error occurred.';
  }
}

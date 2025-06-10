part of 'character_bloc.dart';

@freezed
class CharacterState with _$CharacterState {
  const factory CharacterState.initial() = CharactersInitial;

  const factory CharacterState.loading() = CharactersLoading;

  const factory CharacterState.loaded({
    required List<CharacterEntity> characters,
  }) = CharactersLoaded;

  const factory CharacterState.error(String message) = CharactersError;
}

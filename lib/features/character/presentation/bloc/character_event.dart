part of 'character_bloc.dart';

@freezed
class CharacterEvent with _$CharacterEvent {
  const factory CharacterEvent.loadCharacters() = _LoadCharacters;
  const factory CharacterEvent.toggleFavorite(CharacterEntity character) = _ToggleFavorite;
}

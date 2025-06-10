// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'character_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CharacterEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharacterEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CharacterEvent()';
}


}

/// @nodoc
class $CharacterEventCopyWith<$Res>  {
$CharacterEventCopyWith(CharacterEvent _, $Res Function(CharacterEvent) __);
}


/// @nodoc


class _LoadCharacters implements CharacterEvent {
  const _LoadCharacters();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadCharacters);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CharacterEvent.loadCharacters()';
}


}




/// @nodoc


class _ToggleFavorite implements CharacterEvent {
  const _ToggleFavorite(this.character);
  

 final  CharacterEntity character;

/// Create a copy of CharacterEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleFavoriteCopyWith<_ToggleFavorite> get copyWith => __$ToggleFavoriteCopyWithImpl<_ToggleFavorite>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleFavorite&&(identical(other.character, character) || other.character == character));
}


@override
int get hashCode => Object.hash(runtimeType,character);

@override
String toString() {
  return 'CharacterEvent.toggleFavorite(character: $character)';
}


}

/// @nodoc
abstract mixin class _$ToggleFavoriteCopyWith<$Res> implements $CharacterEventCopyWith<$Res> {
  factory _$ToggleFavoriteCopyWith(_ToggleFavorite value, $Res Function(_ToggleFavorite) _then) = __$ToggleFavoriteCopyWithImpl;
@useResult
$Res call({
 CharacterEntity character
});




}
/// @nodoc
class __$ToggleFavoriteCopyWithImpl<$Res>
    implements _$ToggleFavoriteCopyWith<$Res> {
  __$ToggleFavoriteCopyWithImpl(this._self, this._then);

  final _ToggleFavorite _self;
  final $Res Function(_ToggleFavorite) _then;

/// Create a copy of CharacterEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? character = null,}) {
  return _then(_ToggleFavorite(
null == character ? _self.character : character // ignore: cast_nullable_to_non_nullable
as CharacterEntity,
  ));
}


}

/// @nodoc
mixin _$CharacterState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharacterState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CharacterState()';
}


}

/// @nodoc
class $CharacterStateCopyWith<$Res>  {
$CharacterStateCopyWith(CharacterState _, $Res Function(CharacterState) __);
}


/// @nodoc


class CharactersInitial implements CharacterState {
  const CharactersInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharactersInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CharacterState.initial()';
}


}




/// @nodoc


class CharactersLoading implements CharacterState {
  const CharactersLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharactersLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CharacterState.loading()';
}


}




/// @nodoc


class CharactersLoaded implements CharacterState {
  const CharactersLoaded({required final  List<CharacterEntity> characters}): _characters = characters;
  

 final  List<CharacterEntity> _characters;
 List<CharacterEntity> get characters {
  if (_characters is EqualUnmodifiableListView) return _characters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_characters);
}


/// Create a copy of CharacterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CharactersLoadedCopyWith<CharactersLoaded> get copyWith => _$CharactersLoadedCopyWithImpl<CharactersLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharactersLoaded&&const DeepCollectionEquality().equals(other._characters, _characters));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_characters));

@override
String toString() {
  return 'CharacterState.loaded(characters: $characters)';
}


}

/// @nodoc
abstract mixin class $CharactersLoadedCopyWith<$Res> implements $CharacterStateCopyWith<$Res> {
  factory $CharactersLoadedCopyWith(CharactersLoaded value, $Res Function(CharactersLoaded) _then) = _$CharactersLoadedCopyWithImpl;
@useResult
$Res call({
 List<CharacterEntity> characters
});




}
/// @nodoc
class _$CharactersLoadedCopyWithImpl<$Res>
    implements $CharactersLoadedCopyWith<$Res> {
  _$CharactersLoadedCopyWithImpl(this._self, this._then);

  final CharactersLoaded _self;
  final $Res Function(CharactersLoaded) _then;

/// Create a copy of CharacterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? characters = null,}) {
  return _then(CharactersLoaded(
characters: null == characters ? _self._characters : characters // ignore: cast_nullable_to_non_nullable
as List<CharacterEntity>,
  ));
}


}

/// @nodoc


class CharactersError implements CharacterState {
  const CharactersError(this.message);
  

 final  String message;

/// Create a copy of CharacterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CharactersErrorCopyWith<CharactersError> get copyWith => _$CharactersErrorCopyWithImpl<CharactersError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CharactersError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CharacterState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $CharactersErrorCopyWith<$Res> implements $CharacterStateCopyWith<$Res> {
  factory $CharactersErrorCopyWith(CharactersError value, $Res Function(CharactersError) _then) = _$CharactersErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CharactersErrorCopyWithImpl<$Res>
    implements $CharactersErrorCopyWith<$Res> {
  _$CharactersErrorCopyWithImpl(this._self, this._then);

  final CharactersError _self;
  final $Res Function(CharactersError) _then;

/// Create a copy of CharacterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CharactersError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

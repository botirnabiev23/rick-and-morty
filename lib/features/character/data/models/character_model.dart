import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/db/app_database.dart';
import 'package:rick_and_morty/features/character/domain/entities/character_entity.dart';
import 'package:drift/drift.dart';

part 'character_model.g.dart';

@JsonSerializable()
class CharacterModel extends CharacterEntity {
  const CharacterModel({
    required super.id,
    required super.name,
    required super.status,
    required super.species,
    required super.image,
    super.isFavorite = false,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      image: json['image'] as String,
      isFavorite: false,
    );
  }

  Map<String, dynamic> toJson() => _$CharacterModelToJson(this);

  CharactersCompanion toDrift() {
    return CharactersCompanion(
      id: Value(id),
      name: Value(name),
      status: Value(status),
      image: Value(image),
      species: Value(species),
      isFavorite: Value(isFavorite),
    );
  }

  factory CharacterModel.fromDrift(Character data) {
    return CharacterModel(
      id: data.id,
      name: data.name,
      status: data.status,
      species: data.species,
      image: data.image,
      isFavorite: data.isFavorite,
    );
  }

  factory CharacterModel.fromEntity(CharacterEntity entity) {
    return CharacterModel(
      id: entity.id,
      name: entity.name,
      status: entity.status,
      species: entity.species,
      image: entity.image,
      isFavorite: entity.isFavorite,
    );
  }
}

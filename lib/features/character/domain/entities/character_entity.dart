import 'package:equatable/equatable.dart';

class CharacterEntity extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String image;
  final bool isFavorite;

  const CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.image,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [id, name, status, species, image, isFavorite];

  CharacterEntity copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? image,
    bool? isFavorite,
  }) {
    return CharacterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

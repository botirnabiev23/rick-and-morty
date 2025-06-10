import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character/presentation/bloc/character_bloc.dart';

enum SortOption { name, status }

class SelectedPage extends StatefulWidget {
  const SelectedPage({super.key});

  @override
  State<SelectedPage> createState() => _SelectedPageState();
}

class _SelectedPageState extends State<SelectedPage> {
  SortOption _sortOption = SortOption.name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Избранные персонажи'),
        actions: [
          DropdownButton<SortOption>(
            value: _sortOption,
            icon: const Icon(Icons.sort, color: Colors.black),
            dropdownColor: Colors.white,
            underline: const SizedBox(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _sortOption = value);
              }
            },
            items: const [
              DropdownMenuItem(value: SortOption.name, child: Text('По имени')),
              DropdownMenuItem(
                value: SortOption.status,
                child: Text('По статусу'),
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state is CharactersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CharactersLoaded) {
            List favoriteCharacters =
                state.characters
                    .where((character) => character.isFavorite)
                    .toList();

            if (_sortOption == SortOption.name) {
              favoriteCharacters.sort((a, b) => a.name.compareTo(b.name));
            } else if (_sortOption == SortOption.status) {
              favoriteCharacters.sort((a, b) => a.status.compareTo(b.status));
            }

            if (favoriteCharacters.isEmpty) {
              return const Center(child: Text('Нет избранных персонажей'));
            }

            return ListView.builder(
              itemCount: favoriteCharacters.length,
              itemBuilder: (context, index) {
                final character = favoriteCharacters[index];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(character.image),
                  ),
                  title: Text(character.name),
                  subtitle: Text('${character.species} — ${character.status}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.star, color: Colors.amber),
                    onPressed: () {
                      context.read<CharacterBloc>().add(
                        CharacterEvent.toggleFavorite(character),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is CharactersError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Нажмите кнопку для загрузки'));
          }
        },
      ),
    );
  }
}

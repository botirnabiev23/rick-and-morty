import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/theme/theme_notifier.dart';
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
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final themeNotifier = context.read<ThemeNotifier>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Избранные персонажи'),
        actions: [
          Row(
            children: [
              Icon(
                Icons.light_mode,
                color: isDarkTheme ? Colors.grey : Colors.amber,
              ),
              Switch(
                value: themeNotifier.themeMode == ThemeMode.dark,
                onChanged: (_) => themeNotifier.toggleTheme(),
              ),
              Icon(
                Icons.dark_mode,
                color: isDarkTheme ? Colors.amber : Colors.grey,
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).cardColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            alignment: Alignment.centerLeft,
            child: DropdownButton<SortOption>(
              value: _sortOption,
              onChanged: (value) {
                if (value != null) {
                  setState(() => _sortOption = value);
                }
              },
              items: const [
                DropdownMenuItem(
                  value: SortOption.name,
                  child: Text('По имени'),
                ),
                DropdownMenuItem(
                  value: SortOption.status,
                  child: Text('По статусу'),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<CharacterBloc, CharacterState>(
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
                    favoriteCharacters.sort(
                      (a, b) => a.status.compareTo(b.status),
                    );
                  }

                  if (favoriteCharacters.isEmpty) {
                    return const Center(
                      child: Text('Нет избранных персонажей'),
                    );
                  }

                  return ListView.builder(
                    itemCount: favoriteCharacters.length,
                    itemBuilder: (context, index) {
                      final character = favoriteCharacters[index];

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              character.image.isNotEmpty
                                  ? CachedNetworkImageProvider(character.image)
                                  : const AssetImage(
                                        'assets/images/default_avatar.png',
                                      )
                                      as ImageProvider,
                        ),
                        title: Text(character.name),
                        subtitle: Text(
                          '${character.species} — ${character.status}',
                        ),
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
                  return const Center(
                    child: Text('Нажмите кнопку для загрузки'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

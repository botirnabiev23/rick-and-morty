import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/theme/theme_notifier.dart';
import '../bloc/character_bloc.dart';

enum SortOption { name, status }

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  SortOption _sortOption = SortOption.name;

  @override
  void initState() {
    super.initState();
    context.read<CharacterBloc>().add(CharacterEvent.loadCharacters());
  }

  Future<void> _refreshCharacters() async {
    context.read<CharacterBloc>().add(CharacterEvent.loadCharacters());
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final themeNotifier = context.read<ThemeNotifier>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Characters', style: TextStyle(fontSize: 18)),
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
                  child: Text('Сортировка по имени'),
                ),
                DropdownMenuItem(
                  value: SortOption.status,
                  child: Text('Сортировка по статусу'),
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
                  List characters = List.of(state.characters);

                  if (_sortOption == SortOption.name) {
                    characters.sort((a, b) => a.name.compareTo(b.name));
                  } else if (_sortOption == SortOption.status) {
                    characters.sort((a, b) => a.status.compareTo(b.status));
                  }

                  if (characters.isEmpty) {
                    return const Center(child: Text('No characters found'));
                  }

                  return RefreshIndicator(
                    onRefresh: _refreshCharacters,
                    child: ListView.separated(
                      itemCount: characters.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final character = characters[index];

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                character.image.isNotEmpty
                                    ? CachedNetworkImageProvider(
                                      character.image,
                                    )
                                    : const AssetImage(
                                          'assets/images/default_avatar.png',
                                        )
                                        as ImageProvider,
                          ),
                          title: Text(character.name),
                          subtitle: Text(character.status),
                          trailing: IconButton(
                            icon: Icon(
                              character.isFavorite
                                  ? Icons.star
                                  : Icons.star_border,
                              color:
                                  character.isFavorite
                                      ? Colors.amber
                                      : Colors.grey,
                            ),
                            onPressed: () {
                              context.read<CharacterBloc>().add(
                                CharacterEvent.toggleFavorite(character),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is CharactersError) {
                  return Center(
                    child: Text(
                      'Error: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else {
                  return const Center(child: Text('No data'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/core/di/injection.dart';
import 'package:rick_and_morty/features/character/presentation/bloc/character_bloc.dart';
import 'package:rick_and_morty/features/character/presentation/pages/character_list_page.dart';
import 'package:rick_and_morty/features/main/main_page.dart';
import 'package:rick_and_morty/features/selected/selected_page.dart';
import 'package:rick_and_morty/router/app_routes.dart';


final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.home.path,
  routes: [
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home.path,
              name: AppRoutes.home.name,
              builder: (_, state) => const CharacterListPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.selected.path,
              name: AppRoutes.selected.name,
              builder: (_, state) => const SelectedPage(),
            ),
          ],
        ),
      ],
      builder: (_, __, navigationShell) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<CharacterBloc>(
              create: (_) => getIt<CharacterBloc>(),
            ),
          ],
          child: MainPage(
            navigationShell: navigationShell,
          ),
        );
      },
    ),
  ],
);

// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:rick_and_morty/core/di/injection_module.dart' as _i15;
import 'package:rick_and_morty/db/app_database.dart' as _i296;
import 'package:rick_and_morty/features/character/data/data_sources/character_remote_data_source.dart'
    as _i980;
import 'package:rick_and_morty/features/character/data/repositories/character_repository_impl.dart'
    as _i158;
import 'package:rick_and_morty/features/character/domain/repositories/character_repository.dart'
    as _i1064;
import 'package:rick_and_morty/features/character/domain/use_cases/get_characters_use_case.dart'
    as _i207;
import 'package:rick_and_morty/features/character/domain/use_cases/get_favourite_ids_use_cases.dart'
    as _i978;
import 'package:rick_and_morty/features/character/domain/use_cases/toggle_favourite_character_use_cases.dart'
    as _i450;
import 'package:rick_and_morty/features/character/presentation/bloc/character_bloc.dart'
    as _i12;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectableModule = _$InjectableModule();
    await gh.singletonAsync<_i296.AppDatabase>(
      () => injectableModule.database,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => injectableModule.dio());
    gh.lazySingleton<_i980.CharacterRemoteDataSource>(
      () => _i980.CharacterRemoteDataSourceImpl(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i1064.CharacterRepository>(
      () => _i158.CharacterRepositoryImpl(
        gh<_i980.CharacterRemoteDataSource>(),
        gh<_i296.AppDatabase>(),
      ),
    );
    gh.factory<_i450.ToggleFavoriteCharacterUseCase>(
      () => _i450.ToggleFavoriteCharacterUseCase(
        gh<_i1064.CharacterRepository>(),
      ),
    );
    gh.factory<_i978.GetFavoriteCharacterIdsUseCase>(
      () => _i978.GetFavoriteCharacterIdsUseCase(
        gh<_i1064.CharacterRepository>(),
      ),
    );
    gh.lazySingleton<_i207.GetCharactersUseCase>(
      () => _i207.GetCharactersUseCase(gh<_i1064.CharacterRepository>()),
    );
    gh.factory<_i12.CharacterBloc>(
      () => _i12.CharacterBloc(
        getAllCharacters: gh<_i207.GetCharactersUseCase>(),
        getFavoriteIds: gh<_i978.GetFavoriteCharacterIdsUseCase>(),
        toggleFavorite: gh<_i450.ToggleFavoriteCharacterUseCase>(),
      ),
    );
    return this;
  }
}

class _$InjectableModule extends _i15.InjectableModule {}

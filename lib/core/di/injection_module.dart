import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/db/app_database.dart';

@module
abstract class InjectableModule {
  @preResolve
  @singleton
  Future<AppDatabase> get database async => AppDatabase();


  @lazySingleton
  Dio dio() => Dio(BaseOptions(
    baseUrl: 'https://rickandmortyapi.com/api/',
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ));
}

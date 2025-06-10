import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../models/character_model.dart';

abstract interface class CharacterRemoteDataSource {
  Future<List<CharacterModel>> getCharacters();
}

@LazySingleton(as: CharacterRemoteDataSource)
class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final Dio dio;

  CharacterRemoteDataSourceImpl(this.dio);

  @override
  Future<List<CharacterModel>> getCharacters() async {
    try {
      final response = await dio.get('character');
      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        return results.map((json) => CharacterModel.fromJson(json)).toList();
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }
}

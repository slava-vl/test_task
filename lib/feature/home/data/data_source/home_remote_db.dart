import 'package:dio/dio.dart';

import '../model/place.dart';

abstract class IHomeRemoteDB {
  /// Получить главную страницу
  Future<Place> readHome();
}

class HomeRemoteDB implements IHomeRemoteDB {
  final Dio _client;
  const HomeRemoteDB({required Dio client}) : _client = client;

  @override
  Future<Place> readHome() async {
    final response = await _client.get<Map<String, Object?>?>('/f5628f20/4.json');

    final data = response.data;

    if (data == null) {
      throw Exception('Invalid response');
    }

    return Place.fromJson(data);
  }
}

import '../data_source/home_remote_db.dart';

import '../model/place.dart';

abstract class IHomeRepository {
  /// Получить главную страницу
  Future<Place> readHome();
}

class HomeRepository implements IHomeRepository {
  final IHomeRemoteDB _remoteDB;
  const HomeRepository({required IHomeRemoteDB remoteDB}) : _remoteDB = remoteDB;

  @override
  Future<Place> readHome() => _remoteDB.readHome();
}

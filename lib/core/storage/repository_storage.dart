import 'package:dio/dio.dart';
import '../../feature/home/data/data_source/home_remote_db.dart';
import '../../feature/home/data/repository/home_repository.dart';

abstract class IRepositoryStorage {
  IHomeRepository get home;
}

class RepositoryStorage implements IRepositoryStorage {
  final Dio _client;

  RepositoryStorage({required Dio client}) : _client = client;

  @override
  late final home = HomeRepository(
    remoteDB: HomeRemoteDB(client: _client),
  );
}

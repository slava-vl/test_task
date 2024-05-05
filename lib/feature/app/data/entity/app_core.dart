import 'package:dio/dio.dart';

abstract class IAppCore {
  Dio get client;
}

class AppCore implements IAppCore {
  @override
  final Dio client;

  AppCore({required this.client});
}

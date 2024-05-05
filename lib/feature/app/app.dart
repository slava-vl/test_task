import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../config/urls.dart';
import '../../core/router/app_router.dart';
import '../../core/widget/repository_scope.dart';
import '../free_disk_space/presentation/free_disk_space_scope.dart';
import 'data/entity/app_core.dart';
import 'widget/app_core_scope.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCoreScope(
      appCore: AppCore(
        client: Dio(BaseOptions(baseUrl: Url.baseUrl))
          ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true)),
      ),
      child: const RepositoryScope(
        child: FreeDiskSpaceScope(
          child: _MainApp(),
        ),
      ),
    );
  }
}

class _MainApp extends StatelessWidget {
  const _MainApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
    );
  }
}

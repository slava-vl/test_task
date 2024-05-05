import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../feature/home/data/model/payload.dart';
import '../../feature/home/presentation/home_page.dart';
import '../../feature/object_scheme/presentation/object_scheme_page.dart';
import '../../feature/root/root_page.dart';

abstract class AppRouter {
  static GoRouter get router => GoRouter(
        initialLocation: '/home',
        routes: [
          StatefulShellRoute.indexedStack(
            builder: (context, state, shell) => RootPage(key: state.pageKey, shell: shell),
            branches: [
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/home',
                    name: 'Home',
                    builder: (context, state) => HomePage(key: state.pageKey),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/sets',
                    name: 'Sets',
                    builder: (context, state) => const Center(child: Text('Сеты')),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: '/profile',
                    name: 'Profile',
                    builder: (context, state) => const Center(child: Text('Профиль')),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/object_scheme',
            name: 'ObjectScheme',
            builder: (context, state) => ObjectSchemePage(
              key: state.pageKey,
              item: state.extra as Payload,
            ),
          ),
        ],
      );
}

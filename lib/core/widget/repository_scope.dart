import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../extension/build_context.dart';
import '../storage/repository_storage.dart';

class RepositoryScope extends StatelessWidget {
  final Widget child;
  const RepositoryScope({required this.child, super.key});

  static IRepositoryStorage of(BuildContext context) => context.read<IRepositoryStorage>();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<IRepositoryStorage>(
      create: (context) => RepositoryStorage(client: context.appCore.client),
      child: child,
    );
  }
}

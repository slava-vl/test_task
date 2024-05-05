import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/entity/app_core.dart';

class AppCoreScope extends StatelessWidget {
  final Widget child;
  final IAppCore appCore;

  const AppCoreScope({required this.child, required this.appCore, super.key});

  static IAppCore of(BuildContext context) => context.read<IAppCore>();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<IAppCore>(
      create: (context) => appCore,
      child: child,
    );
  }
}

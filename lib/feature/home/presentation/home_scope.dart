import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/extension/build_context.dart';
import '../bloc/home.dart';

class HomeScope extends StatelessWidget {
  final Widget child;
  const HomeScope({required this.child, super.key});

  static void readOf(BuildContext context) => context.read<HomeBloc>().add(const HomeEvent.read());

  static void refreshOf(BuildContext context) => context.read<HomeBloc>().add(const HomeEvent.refresh());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(repository: context.repoStorage.home)..add(const HomeEvent.read()),
      child: child,
    );
  }
}

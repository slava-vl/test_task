import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/free_disk_space.dart';

class FreeDiskSpaceScope extends StatelessWidget {
  final Widget child;
  const FreeDiskSpaceScope({required this.child, super.key});

  static void readOf(BuildContext context) => context.read<FreeDiskSpaceBloc>().add(const FreeDiskSpaceEvent.read());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FreeDiskSpaceBloc>(
      create: (context) => FreeDiskSpaceBloc()..add(const FreeDiskSpaceEvent.read()),
      child: child,
    );
  }
}

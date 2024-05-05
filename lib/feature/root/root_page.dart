import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/bottom_nav_bar.dart';

class RootPage extends StatelessWidget {
  final StatefulNavigationShell shell;
  const RootPage({required this.shell, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 242, 255),
      body: shell,
      bottomNavigationBar: BottomNavBar(shell: shell),
    );
  }
}

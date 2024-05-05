import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/resources/assets.gen.dart';

class BottomNavBar extends StatelessWidget {
  final StatefulNavigationShell shell;
  const BottomNavBar({required this.shell, super.key});

  void _selectTab(int index) => shell.goBranch(index);

  @override
  Widget build(BuildContext context) {
    const spacerWidget = SizedBox(width: 8, height: 8);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: 80,
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          offset: Offset(0, -4),
          blurRadius: 8,
          spreadRadius: 6,
          color: Color.fromRGBO(232, 236, 252, 0.4),
        )
      ]),
      child: Row(
        children: [
          _NavBarItem(
            icon: Assets.icons.home,
            activeIcon: Assets.icons.homeFilled,
            label: 'Объекты',
            isActive: shell.currentIndex == 0,
            onTap: () => _selectTab(0),
          ),
          spacerWidget,
          _NavBarItem(
            icon: Assets.icons.sets,
            activeIcon: Assets.icons.sets,
            label: 'Сеты',
            isActive: shell.currentIndex == 1,
            onTap: () => _selectTab(1),
          ),
          spacerWidget,
          _NavBarItem(
            icon: Assets.icons.profile,
            activeIcon: Assets.icons.profileFilled,
            label: 'Профиль',
            isActive: shell.currentIndex == 2,
            onTap: () => _selectTab(2),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final SvgGenImage icon;
  final SvgGenImage activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  const _NavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const activeColor = Color.fromRGBO(74, 111, 244, 1);
    const iconColor = Color.fromRGBO(101, 103, 110, 1);
    return Expanded(
      child: IconButton(
        onPressed: onTap,
        icon: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              (isActive ? activeIcon : icon).svg(
                colorFilter: ColorFilter.mode(
                  isActive ? activeColor : iconColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: isActive
                    ? const TextStyle(
                        color: activeColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      )
                    : const TextStyle(
                        color: Color.fromRGBO(68, 70, 79, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

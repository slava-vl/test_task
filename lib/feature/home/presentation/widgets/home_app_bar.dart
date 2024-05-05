import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/resources/assets.gen.dart';

class HomeAppBar extends SliverPersistentHeaderDelegate {
  HomeAppBar({
    required this.minHeight,
    required this.maxHeight,
    required this.controller,
  });
  final double minHeight;
  final double maxHeight;
  final TextEditingController controller;

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final positionProgress = getPositionProgress(shrinkOffset);
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white.withOpacity(positionProgress),
      width: deviceWidth,
      height: max(140 - shrinkOffset, 72),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: SafeArea(
              child: AnimatedContainer(
                width: deviceWidth,
                duration: const Duration(milliseconds: 150),
                padding: EdgeInsets.only(
                  right: 6 * (1 - positionProgress),
                  left: 16 * (1 - positionProgress),
                  top: 12 * (1 - positionProgress),
                ),
                child: Row(
                  children: [
                    AnimatedCrossFade(
                      firstChild: IconButton(
                        onPressed: () {},
                        icon: Assets.icons.search.svg(),
                      ),
                      secondChild: const SizedBox(height: 40),
                      crossFadeState: positionProgress > 0.5 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 150),
                    ),
                    Expanded(
                      child: AnimatedAlign(
                        duration: const Duration(milliseconds: 150),
                        alignment: positionProgress > 0.5 ? Alignment.center : Alignment.centerLeft,
                        child: Text(
                          'Объекты',
                          style: TextStyle(
                            fontSize: 22 + 10 * (1 - positionProgress),
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(27, 27, 31, 1),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Assets.icons.info.svg(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            child: AnimatedCrossFade(
              firstChild: Container(
                height: 40,
                width: deviceWidth - 32,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    constraints: const BoxConstraints(maxHeight: 40),
                    contentPadding: EdgeInsets.zero,
                    suffixIcon: Padding(padding: const EdgeInsets.all(8), child: Assets.icons.searchTrailingIcon.svg()),
                    prefixIcon: Padding(padding: const EdgeInsets.all(8), child: Assets.icons.search.svg()),
                    hintText: 'Найти...',
                     
                    border: InputBorder.none,
                  ),
                ),
              ),
              secondChild: SizedBox(width: deviceWidth - 32),
              crossFadeState: positionProgress > 0.4 ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 150),
            ),
          ),
        ],
      ),
    );
  }

  double getPositionProgress(double shrinkOffset) {
    if (shrinkOffset > 60) return 1;
    return shrinkOffset * 100 / 60 / 100;
  }

  @override
  bool shouldRebuild(HomeAppBar oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight;
  }
}

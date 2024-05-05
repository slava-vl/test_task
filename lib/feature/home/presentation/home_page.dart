import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/ui_kit/ui_kit.dart';
import '../bloc/home.dart';
import '../data/model/payload.dart';
import 'home_scope.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/payload.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScope(
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) => state.map(
          progress: (_) => const LoadingLayout(),
          error: (state) => ErrorLayout(message: state.error, onRefresh: () => HomeScope.refreshOf(context)),
          success: (state) => _DataLayout(payload: state.place.payload),
        ),
      ),
    );
  }
}

class _DataLayout extends StatefulWidget {
  final List<Payload> payload;
  const _DataLayout({required this.payload});

  @override
  State<_DataLayout> createState() => _DataLayoutState();
}

class _DataLayoutState extends State<_DataLayout> {
  late final TextEditingController _searchTextController;

  @override
  void initState() {
    _searchTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: HomeAppBar(
            minHeight: 72,
            maxHeight: 140,
            controller: _searchTextController,
          ),
        ),
        _DataList(
          payload: widget.payload,
          controller: _searchTextController,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }
}

class _DataList extends StatelessWidget {
  const _DataList({required this.payload, required this.controller});

  final List<Payload> payload;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        final isSearchMode = controller.text.trim().isNotEmpty;
        var data = payload;
        if (isSearchMode) {
          data = payload.where((e) => e.title.toLowerCase().contains(controller.text.toLowerCase())).toList();
        }
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: data.length,
            (_, index) => PayloadWidget(item: data[index]),
          ),
        );
      },
    );
  }
}

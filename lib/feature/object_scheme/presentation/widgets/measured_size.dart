library measured_size;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

typedef OnWidgetSizeChange = void Function(Size size);

class MeasuredSize extends StatefulWidget {
  final Widget child;
  final OnWidgetSizeChange onChange;
  const MeasuredSize({required this.child, required this.onChange, super.key});

  @override
  State<MeasuredSize> createState() => _MeasuredSizeState();
}

class _MeasuredSizeState extends State<MeasuredSize> {
  final widgetKey = GlobalKey();
  Size? oldSize;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  void postFrameCallback(_) {
    final context = widgetKey.currentContext;
    final newSize = context?.size;
    if (newSize == null || newSize == Size.zero) return;
    if (oldSize == newSize) return;
    oldSize = newSize;
    widget.onChange(newSize);
  }
}

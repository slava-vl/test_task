import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'measured_size.dart';

class MapContainer extends StatefulWidget {
  final Size size;
  final Image child;
  final List<MarkerModel> markers;
  final ValueChanged<MarkerModel>? onMarkerClicked;
  final Widget? Function(double scale, MarkerModel data) markerWidgetBuilder;
  const MapContainer({
    required this.child,
    required this.size,
    required this.markers,
    required this.markerWidgetBuilder,
    super.key,
    this.onMarkerClicked,
  });

  @override
  State<MapContainer> createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer> {
  Offset _offset = Offset.zero;
  double _scale = 1.0;
  late Offset _normalizedOffset;
  late double _previousScale;
  bool _needSetDefaultScaleAndOffset = true;
  double _defaultScale = 1.0;
  double _defaultScaleX = 1.0;
  double _defaultScaleY = 1.0;

  List<MarkerModel> _markers = [];

  @override
  void initState() {
    super.initState();
  }

  double _clampScale(double scale) {
    return scale.clamp(_defaultScale, 10).toDouble();
  }

  Offset _clampOffset(Offset offset) {
    if (context.size == null) {
      return offset;
    }
    final size = context.size!;
    if (_defaultScaleX > _defaultScaleY) {
      final per = _defaultScaleY / _defaultScaleX;
      final xSize = size.width * _scale;
      final xOffsetMax = xSize * (per - 1) / 2 + 0.01;
      final xOffsetMin = -(xSize - xSize * (1 - per) / 2 - size.width);
      return Offset(offset.dx.clamp(xOffsetMin, xOffsetMax), offset.dy.clamp(size.height * (1 - _scale), 0.0));
    } else {
      final per = _defaultScaleX / _defaultScaleY;
      final ySize = size.height * _scale;
      final yOffsetMax = ySize * (per - 1) / 2 + 0.01;
      final yOffsetMin = -(ySize - ySize * (1 - per) / 2 - size.height);
      return Offset(offset.dx.clamp(size.width * (1 - _scale), 0.0), offset.dy.clamp(yOffsetMin, yOffsetMax));
    }
  }

  void _onScaleStart(ScaleStartDetails details) {
    setState(() {
      _previousScale = _scale;
      _normalizedOffset = (details.localFocalPoint - _offset) / _scale;
    });
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = _clampScale(_previousScale * details.scale);
      _offset = _clampOffset(details.localFocalPoint - _normalizedOffset * _scale);
    });
  }

  Future<void> _onPressMarker(BuildContext context, MarkerModel markerModel) async {
    if (widget.onMarkerClicked != null) widget.onMarkerClicked!(markerModel);
  }

  List<Widget> _getMapWidgetWithMarker(double scale, List<MarkerModel> markers) {
    return [
      Container(
          margin: EdgeInsets.zero,
          constraints: const BoxConstraints(
            minWidth: double.maxFinite,
            minHeight: double.infinity,
          ),
          transform: Matrix4.identity()
            ..translate(_offset.dx, _offset.dy)
            ..scale(_scale, _scale),
          child: widget.child),
      ..._getMarkerWidgetList(scale, markers),
    ];
  }

  List<Widget> _getMarkerWidgetList(double scale, List<MarkerModel> markers) {
    final result = <Widget>[];
    for (final element in _markers) {
      final childWidget = Wrap(
        children: [
          InkWell(
            onTap: () => _onPressMarker(context, element),
            child: widget.markerWidgetBuilder(scale, element),
          )
        ],
      );

      result.add(Container(
          transform: Matrix4.identity()
            ..translate(_offset.dx + element.offset.dx * scale - 0.5 * element.size.width,
                _offset.dy + element.offset.dy * scale - 1 * element.size.height),
          child: MeasuredSize(
              onChange: (size) {
                setState(() {
                  element.size = size;
                });
              },
              child: childWidget)));
    }
    return result;
  }

  void calculateMarkerPosition() {
    if (_markers.isNotEmpty || widget.markers.isEmpty || context.size == null) {
      return;
    }
    final size = context.size!;
    final markerCalculated = <MarkerModel>[];
    final scaleX = size.width / widget.size.width;
    final scaleY = size.height / widget.size.height;
    final double scale = math.min(scaleX, scaleY);
    for (final element in widget.markers) {
      final dx = (size.width - widget.size.width * scale) / 2 + scale * element.offset.dx;
      final dy = (size.height - widget.size.height * scale) / 2 + scale * element.offset.dy;
      element.offset = Offset(dx, dy);
      markerCalculated.add(element);
    }
    setState(() {
      _markers = markerCalculated;
    });
  }

  void calculateDefaultScaleAndOffset() {
    if (!_needSetDefaultScaleAndOffset || context.size == null) return;
    final size = context.size!;
    _defaultScaleX = size.width / widget.size.width;
    _defaultScaleY = size.height / widget.size.height;
    final double scaleMax = math.max(_defaultScaleX, _defaultScaleY);
    final double scaleMin = math.min(_defaultScaleX, _defaultScaleY);
    setState(() {
      _defaultScale = scaleMax / scaleMin;
      _scale = _defaultScale;
      _offset = Offset((size.width * (1 - _scale)) / 2, size.height * (1 - _scale) / 2);
      _needSetDefaultScaleAndOffset = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calculateDefaultScaleAndOffset();
      calculateMarkerPosition();
    });
    return GestureDetector(
        onScaleStart: _onScaleStart,
        onScaleUpdate: _onScaleUpdate,
        behavior: HitTestBehavior.translucent,
        child: Stack(children: _getMapWidgetWithMarker(_scale, _markers)));
  }
}

class MarkerModel<T> {
  static const defaultSize = Size(40, 40);
  final T data;
  Offset offset;
  Size size;

  MarkerModel(this.data, this.offset, {this.size = defaultSize});
}

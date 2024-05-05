import 'package:freezed_annotation/freezed_annotation.dart';

part 'point.freezed.dart';
part 'point.g.dart';

@freezed
class Point with _$Point {
  const factory Point({
    required final double x,
    required final double y,
    required final PointStatus status,
  }) = _Point;

  factory Point.fromJson(Map<String, Object?> json) => _$PointFromJson(json);
}

enum PointStatus { incompleted, completed }

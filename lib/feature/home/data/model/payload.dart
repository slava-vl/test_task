import 'package:freezed_annotation/freezed_annotation.dart';

import 'point.dart';

part 'payload.freezed.dart';
part 'payload.g.dart';

@freezed
class Payload with _$Payload {
  const factory Payload({
    required final String title,
    @JsonKey(name: 'remaining_points') required final int remainingPoints,
    @JsonKey(name: 'total_points_count') required final int totalPointsCount,
    required final List<Point> points,
  }) = _Payload;

  factory Payload.fromJson(Map<String, Object?> json) => _$PayloadFromJson(json);
}

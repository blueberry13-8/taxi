import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';

part 'order.g.dart';

@freezed
class Order with _$Order {
  const factory Order({
    required String id,
    required String origin,
    required String destination,
    @JsonKey(required: false,) String? description,
    @JsonKey(name: 'time_start', fromJson: TimeConverter.timestampToDateTime, toJson: TimeConverter.dateTimeToTimestamp,) required DateTime timeStart,
    @JsonKey(name: 'time_to', fromJson: TimeConverter.timestampToDateTime, toJson: TimeConverter.dateTimeToTimestamp,) required DateTime timeTo,
    @JsonKey(name: 'volunteer_id', required: false,) String? volunteerId,
    @JsonKey(name: 'customer_id',) required String customerId,
  }) = _Order;

  factory Order.fromJson(Map<String, Object?> json) => _$OrderFromJson(json);
}

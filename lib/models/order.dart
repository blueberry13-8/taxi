import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';

part 'order.g.dart';

@freezed
class Order with _$Order {
  const factory Order({
    required int id,
    required String origin,
    required String destination,
    @JsonKey(name: 'comment', required: false,) String? description,
    @JsonKey(name: 'start_time', fromJson: TimeConverter.timestampToDateTime, toJson: TimeConverter.dateTimeToTimestamp,) required DateTime timeStart,
    @JsonKey(name: 'time_end', fromJson: TimeConverter.timestampToDateTime, toJson: TimeConverter.dateTimeToTimestamp,) required DateTime timeTo,
    @JsonKey(name: 'volunteer_token', required: false,) String? volunteerId,
    @JsonKey(name: 'customer_token',) required String customerId,
  }) = _Order;

  factory Order.fromJson(Map<String, Object?> json) => _$OrderFromJson(json);


}

class TimeConverter {
  static DateTime timestampToDateTime(int timestamp) => DateTime.fromMillisecondsSinceEpoch(timestamp);

  static int dateTimeToTimestamp(DateTime dateTime) => dateTime.millisecondsSinceEpoch;
}

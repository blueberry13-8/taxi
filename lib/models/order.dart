import 'package:freezed_annotation/freezed_annotation.dart';

part 'order.freezed.dart';

part 'order.g.dart';

@freezed
class Order with _$Order {
  const factory Order({
    @JsonKey(name: 'full_name') required String initialPlace,
    @JsonKey(name: 'destination_place') required String destinationPlace,
    @JsonKey(name: 'time_from') required int timeFrom,
    @JsonKey(name: 'time_to') required int timeTo,
  }) = _Order;

  factory Order.fromJson(Map<String, Object?> json) => _$OrderFromJson(json);
}

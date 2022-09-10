import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class Customer with _$Customer {
  const factory Customer({
    required String id,
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'phone_number') required String phoneNumber,
    required String password,
    @JsonKey(name: 'open_orders') required List<String> openOrders,
    @JsonKey(name: 'in_progress_orders') required List<String> inProgressOrders,
  }) = _Customer;

  factory Customer.fromJson(Map<String, Object?> json) => _$CustomerFromJson(json);

}
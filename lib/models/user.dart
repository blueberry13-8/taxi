import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

part 'user.g.dart';

enum Role {
  @JsonValue('customer')
  customer,
  @JsonValue('volunteer')
  volunteer,
  @JsonValue('moderator')
  moderator,
}

@freezed
class User with _$User {
  const factory User({
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'phone_number') required String phoneNumber,
    required String password,
    @JsonKey(name: 'role') required Role role,
    required List<String> orders,
  }) = _User;

  factory User.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
}

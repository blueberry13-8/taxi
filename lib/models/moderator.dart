import 'package:freezed_annotation/freezed_annotation.dart';

part 'moderator.freezed.dart';

part 'moderator.g.dart';

@freezed
class Moderator with _$Moderator {
  const factory Moderator({
    required String id,
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'phone_number') required String phoneNumber,
    required String password,
  }) = _Moderator;

  factory Moderator.fromJson(Map<String, Object?> json) =>
      _$ModeratorFromJson(json);
}

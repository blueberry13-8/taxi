import 'package:freezed_annotation/freezed_annotation.dart';

part 'volunteer.freezed.dart';
part 'volunteer.g.dart';

@freezed
class Volunteer with _$Volunteer {
  const factory Volunteer({
    required List<String> orders,
    required String id,
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'phone_number') required String phoneNumber,
    required String password,
  }) = _Volunteer;

  factory Volunteer.fromJson(Map<String, Object?> json) => _$VolunteerFromJson(json);
}
import 'data.dart';

class PrayerTimesResponse {
  int? code;
  String? status;
  Data? data;

  PrayerTimesResponse({this.code, this.status, this.data});

  factory PrayerTimesResponse.fromJson(Map<String, dynamic> json) {
    return PrayerTimesResponse(
      code: json['code'] as int?,
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

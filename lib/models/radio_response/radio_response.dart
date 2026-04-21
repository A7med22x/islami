import 'package:islami/models/radio_response/radio.dart';

class RadioResponse {
  final List<Radio> radios;

  const RadioResponse({required this.radios});

  factory RadioResponse.fromJson(Map<String, dynamic> json) => RadioResponse(
    radios: (json['radios'] as List<dynamic>)
        .map((e) => Radio.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

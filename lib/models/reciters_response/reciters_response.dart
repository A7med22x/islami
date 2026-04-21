import 'reciter.dart';

class RecitersResponse {
  List<Reciter> reciters;

  RecitersResponse({required this.reciters});

  factory RecitersResponse.fromJson(Map<String, dynamic> json) {
    return RecitersResponse(
      reciters: (json['reciters'] as List<dynamic>)
          .map((e) => Reciter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

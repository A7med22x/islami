import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:islami/models/radio_response/radio.dart';
import 'package:islami/models/radio_response/radio_response.dart';
import 'package:islami/models/reciters_response/reciter.dart';
import 'package:islami/models/reciters_response/reciters_response.dart';

class ApiManager {
  Future<List<Radio>> getRadioData() async {
    try {
      Uri uri = Uri.parse('https://mp3quran.net/api/v3/radios?language=ar');
      final response = await http.get(uri);
      Map<String, dynamic> json = jsonDecode(response.body);
      final radioResponse = RadioResponse.fromJson(json);
      return radioResponse.radios;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Reciter>> getReciterData() async {
    try {
      Uri uri = Uri.parse('https://www.mp3quran.net/api/v3/reciters?language=ar');
      final response = await http.get(uri);
      Map<String, dynamic> json = jsonDecode(response.body);
      final radioResponse = RecitersResponse.fromJson(json);
      return radioResponse.reciters;
    } catch (e) {
      rethrow;
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:islami/models/prayer_times_response/prayer_times_response.dart';
import 'package:islami/models/radio_response/radio.dart';
import 'package:islami/models/radio_response/radio_response.dart';
import 'package:islami/models/reciters_response/reciter.dart';
import 'package:islami/models/reciters_response/reciters_response.dart';
import 'package:islami/models/tafasir/tafsir.dart';
import 'package:islami/models/tafasir/tafsir_response.dart';

class ApiManager {
  Future<List<Radio>> getRadioData() async {
    try {
      Uri uri = Uri.parse('http://mp3quran.net/api/v3/radios?language=ar');
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
      Uri uri = Uri.parse(
        'http://www.mp3quran.net/api/v3/reciters?language=ar',
      );
      final response = await http.get(uri);
      Map<String, dynamic> json = jsonDecode(response.body);
      final recitersResponse = RecitersResponse.fromJson(json);
      return recitersResponse.reciters;
    } catch (e) {
      rethrow;
    }
  }
  
  Future<List<Tafsir>> getTafasirData() async {
    try {
      Uri uri = Uri.parse(
        'https://www.mp3quran.net/api/v3/tafsir?tafsir=9&language=ar',
      );
      final response = await http.get(uri);
      Map<String, dynamic> json = jsonDecode(response.body);
      final tafasirResponse = TafsirResponse.fromJson(json);
      return tafasirResponse.tafasir;
    } catch (e) {
      rethrow;
    }
  }

  static Future<PrayerTimesResponse> getPrayer() async {
    try {
      final date = DateFormat('dd-MM-yyyy').format(DateTime.now());
      Uri uri = Uri.parse(
        'http://api.aladhan.com/v1/timingsByCity/$date?city=cairo&country=egypt',
      );
      final response = await http.get(uri);
      Map<String, dynamic> json = jsonDecode(response.body);
      return PrayerTimesResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }
}

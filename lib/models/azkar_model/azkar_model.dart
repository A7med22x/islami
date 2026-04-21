import 'dart:convert';

import 'package:flutter/services.dart';

class AzkarModel {
  String? category;
  String? count;
  String? description;
  String? reference;
  String? content;

  AzkarModel({
    this.category,
    this.count,
    this.description,
    this.reference,
    this.content,
  });

  factory AzkarModel.fromJson(Map<String, dynamic> json) => AzkarModel(
    category: json['category'] as String?,
    count: json['count'] as String?,
    description: json['description'] as String?,
    reference: json['reference'] as String?,
    content: json['content'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'category': category,
    'count': count,
    'description': description,
    'reference': reference,
    'content': content,
  };

  static Future<List<AzkarModel>> loadAzkarData(String azkarType) async {
    final response = await rootBundle.loadString('assets/texts/azkar.json');
    final content = jsonDecode(response);
    if (content[azkarType] is List) {
      return (content[azkarType] as List)
          .map((e) => AzkarModel.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }
}

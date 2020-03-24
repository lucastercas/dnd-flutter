import 'dart:convert';

import 'package:flutter/services.dart';

Future<String> readJson(String filePath) async {
  return await rootBundle.loadString(filePath);
}

Future<Map<String, dynamic>> parseJson(String filePath) async {
  String jsonData = await readJson(filePath);
  Map<String, dynamic> decoded = jsonDecode(jsonData);
  return decoded;
}

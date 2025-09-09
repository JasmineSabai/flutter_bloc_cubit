import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static final SharedPreferenceService _instance = SharedPreferenceService._internal();
  factory SharedPreferenceService() => _instance;
  SharedPreferenceService._internal();

  Future<String> loadStringData({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  Future<bool> loadBoolData({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  Future<T> loadJsonData<T>({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    var json = prefs.getString(key) ?? '';
    var value = JsonDecoder().convert(json);
    return value;
  }

  Future<void> saveStringData({required String key, required String value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> saveBoolData({required String key, required bool value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> saveJsonData<T>({required String key, required T value}) async {
    final prefs = await SharedPreferences.getInstance();
    var json = JsonEncoder().convert(value);
    await prefs.setString(key, json);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
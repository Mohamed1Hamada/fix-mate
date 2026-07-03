import 'dart:convert';
import 'package:fixmate/features/auth/sign_in/models/technician_model.dart';
import 'package:fixmate/features/auth/sign_in/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  //! Initialize the cache
  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  //! Save basic types
  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    } else if (value is String) {
      return await sharedPreferences.setString(key, value);
    } else if (value is int) {
      return await sharedPreferences.setInt(key, value);
    } else if (value is double) {
      return await sharedPreferences.setDouble(key, value);
    } else {
      throw Exception('Unsupported type');
    }
  }

  dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  String? getDataString({required String key}) {
    return sharedPreferences.getString(key);
  }

  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }

  Future<bool> containsKey({required String key}) async {
    return sharedPreferences.containsKey(key);
  }

//! Save CustomerModel in local storage
  Future<bool> saveUserModel(UserModel customer) async {
    // نحول CustomerModel إلى json
    final customerJson = jsonEncode(customer.toJson());

    // نخزنها في SharedPreferences
    return await sharedPreferences.setString('user', customerJson);
  }

  UserModel? getUserModel() {
    final customerJson = sharedPreferences.getString('user');

    if (customerJson == null) return null; // لو مفيش داتا

    final Map<String, dynamic> decodedJson = jsonDecode(customerJson);

    return UserModel.fromJson(decodedJson);
  }

  //! Save TechnicianModel in local storage
  Future<bool> saveTechnicianModel(TechnicianModel technician) async {
    final jsonString = jsonEncode(technician.toJson());
    return await sharedPreferences.setString('technician', jsonString);
  }

  TechnicianModel? getTechnicianModel() {
    final jsonString = sharedPreferences.getString('technician');
    if (jsonString == null) return null;
    final Map<String, dynamic> decodedJson = jsonDecode(jsonString);
    return TechnicianModel.fromJson(decodedJson);
  }
}

import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zxvision1/data/api/api_client.dart';
import 'package:zxvision1/data/api/http_client.dart';
import 'package:zxvision1/models/user_model.dart';
import 'package:zxvision1/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class UserRepo {
  final ApiClient apiClient;
  final HttpClient httpClient;
  final SharedPreferences sharedPreferences;
  UserRepo({
    required this.apiClient,
    required this.httpClient,
    required this.sharedPreferences,
  });
  // Future<Response> getUserInfo() async {
  //   return await apiClient.getData(AppConstants.USER_INFO_URI);
  // }
  Future<http.Response> getUserInfo() async {
    return await httpClient.postData(AppConstants.LOGIN_URL, {
      "email": UserModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ACCOUNT)!)).email,
      "password": UserModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ACCOUNT)!)).password,
    });
  }

  Future<http.Response> getUserAddresses(String userId) async {
    return await httpClient.postData(AppConstants.ADDRESS_LIST_URL, {"user_id": userId});
  }
}
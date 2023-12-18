import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zxvision1/data/api/api_client.dart';
import 'package:zxvision1/data/api/http_client.dart';
import 'package:zxvision1/models/address_model.dart';
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

  Future<http.Response> getAddressFromGeocode(LatLng latLng) async {
    final url = '${AppConstants.MAP_HOST}?key=${AppConstants.APP_API}&language=en&latlng=${latLng.latitude},${latLng.longitude}';
    var response = await http.get(Uri.parse(url));
    print("getAddressFromGeocode"+response.toString());
    if(response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      String _formattedAddress = data["results"][0]["formatted_address"];
      print("response ==== $_formattedAddress");
    }
    return response;
  }

  Future<http.Response> setLocationByHttp(String placeID) async {
    return await httpClient.getData(AppConstants.PLACE_DETAILS_URL+placeID+'&key='+AppConstants.APP_API);
  }

  Future<http.Response> searchLocationByHttp(String text) async {
    return await httpClient.getData(AppConstants.SEARCH_LOCATION_URL+text+'&key='+AppConstants.APP_API);
  }

  Future<http.Response> addAddress(AddressModel addressModel) async {
    var newJson = addressModel.toJson();
    newJson.putIfAbsent("user_id", () => UserModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ACCOUNT)!)).id);
    newJson.putIfAbsent("created_at", () => DateTime.now().toString());
    newJson.putIfAbsent("updated_at", () => DateTime.now().toString());
    return await httpClient.postData(AppConstants.ADD_USER_ADDRESS_URL, newJson);
  }
}
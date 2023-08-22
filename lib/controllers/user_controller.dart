import 'dart:convert';

import 'package:get/get.dart';
import 'package:zxvision1/data/repository/auth_repo.dart';
import 'package:zxvision1/data/repository/user_repo.dart';
import 'package:zxvision1/models/response_model.dart';
import 'package:zxvision1/models/signup_body_model.dart';
import 'package:zxvision1/models/user_model.dart';
import 'package:http/http.dart' as http;

import '../models/address_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({
    required this.userRepo,
  });

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  UserModel? _userModel;
  UserModel? get userModel=>_userModel;

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList=>_addressList;

  Future<ResponseModel> getUserInfo() async {
    http.Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(jsonDecode(response.body));
      _isLoading = true;
      responseModel = ResponseModel(true, "successfully");
    } else {
      responseModel = ResponseModel(false, "get user info fails");
    }
    update();
    return responseModel;
  }

  Future<void> getUserAddressList(String userId) async {
    print("user controller @ getUserAddressList");
    http.Response response = await userRepo.getUserAddresses(userId);
    if (response.statusCode == 200) {
      _addressList = [];
      _addressList.addAll(AddressList.fromJson(jsonDecode(response.body)).addresses);
    } else {
      _addressList = [];
    }
    update();
  }
}
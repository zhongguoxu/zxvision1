import 'dart:convert';

import 'package:get/get.dart';
import 'package:zxvision1/data/repository/order_repo.dart';
import 'package:http/http.dart' as http;
import 'package:zxvision1/models/order_model.dart';
import 'package:zxvision1/models/place_order_model.dart';

import '../models/response_model.dart';

class OrderController extends GetxController implements GetxService {
  OrderRepo orderRepo;
  OrderController({
    required this.orderRepo,
  });

  bool _isLoading = false;
  bool get isLoading=>_isLoading;

  Future<void> placeOrder(PlaceOrderBody placeOrderBody, Function callback) async {
    _isLoading = true;
    update();
    http.Response response = await orderRepo.placeOrder(placeOrderBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      String message = jsonDecode(response.body)['message'];
      String orderId = jsonDecode(response.body)['order_id'];
      callback(true, message, orderId);
      // authRepo.saveUserAccount(UserModel.fromJson(jsonDecode(response.body)));
      // responseModel = ResponseModel(true, "Login successfully");
      // print("login successfully");
    } else {
      callback(false, "Place order fails", "-1");
      // responseModel = ResponseModel(false, "Login fails");
      // print("login fails");
    }
    _isLoading = false;
    update();
    // return responseModel;
  }
}
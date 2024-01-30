import 'dart:convert';

import 'package:get/get.dart';
import 'package:zxvision1/data/repository/order_repo.dart';
import 'package:http/http.dart' as http;
import 'package:zxvision1/models/cart_model.dart';
import 'package:zxvision1/models/order_model.dart';
import 'package:zxvision1/models/place_order_model.dart';
import 'package:zxvision1/models/products_model.dart';

import '../models/response_model.dart';

class OrderController extends GetxController implements GetxService {
  OrderRepo orderRepo;
  OrderController({
    required this.orderRepo,
  });

  bool _isLoading = false;
  bool get isLoading=>_isLoading;

  List<PlaceOrderBody> _currentOrderList = [];
  List<PlaceOrderBody> _historyOrderList = [];
  List<PlaceOrderBody> get currentOrderList=>_currentOrderList;
  List<PlaceOrderBody> get historyOrderList=>_historyOrderList;

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

  Future<void> getOrderList(String phone) async {
    _isLoading = true;
    update();
    http.Response response = await orderRepo.getOrderList(phone);
    if (response.statusCode == 200) {
      print("zack got order list");
      _historyOrderList = [];
      _currentOrderList = [];
      var orderList = PlaceOrderList.fromJson(jsonDecode(response.body)).placeOrders;
      print("zack order length is " + orderList.length.toString());
      _historyOrderList.addAll(orderList.where((element) => element.orderStatus=="Completed"));
      _currentOrderList.addAll(orderList.where((element) => element.orderStatus!="Completed"));
    } else {
      _historyOrderList = [];
      _currentOrderList = [];
    }

    _isLoading = false;
    update();
  }

  List<CartModel> parseStringToProductList(String productListStr) {
    List<CartModel> productList = [];
    productListStr.split(";").forEach((element) {
      productList.add(parseStringToProduct(element));
    });
    return productList;
  }

  CartModel parseStringToProduct(String productStr) {
    List<String> infoList = productStr.split(',');
    return CartModel(
      name: infoList[0],
      price: double.parse(infoList[1]),
      quantity: int.parse(infoList[2]),
      img: infoList[3],
    );
  }
}
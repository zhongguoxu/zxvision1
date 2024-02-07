import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zxvision1/controllers/auth_controller.dart';
import 'package:zxvision1/controllers/cart_controller.dart';
import 'package:zxvision1/controllers/order_controller.dart';
import 'package:zxvision1/controllers/popular_product_controller.dart';
import 'package:zxvision1/controllers/system_controller.dart';
import 'package:zxvision1/data/api/api_client.dart';
import 'package:zxvision1/data/api/http_client.dart';
import 'package:zxvision1/data/repository/auth_repo.dart';
import 'package:zxvision1/data/repository/cart_repo.dart';
import 'package:zxvision1/data/repository/location_repo.dart';
import 'package:zxvision1/data/repository/order_repo.dart';
import 'package:zxvision1/data/repository/popular_product_repo.dart';
import 'package:zxvision1/data/repository/system_repo.dart';
import 'package:zxvision1/data/repository/user_repo.dart';
import 'package:zxvision1/utils/app_constants.dart';

import '../controllers/location_controller.dart';
import '../controllers/recommended_product_controller.dart';
import '../controllers/user_controller.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(() => HttpClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  //repos
  Get.lazyPut(() => SystemRepo(httpClient: Get.find()));
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find(), httpClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find(), httpClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  // Get.lazyPut(() => AuthRepo(apiClient: Get.find(), httpClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find(), httpClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient: Get.find(), httpClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => OrderRepo(httpClient: Get.find()));


  //controllers
  Get.lazyPut(() => SystemController(systemRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  // Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));

}
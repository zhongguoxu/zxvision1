import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zxvision1/controllers/cart_controller.dart';
import 'package:zxvision1/controllers/popular_product_controller.dart';
import 'package:zxvision1/data/api/api_client.dart';
import 'package:zxvision1/data/repository/cart_repo.dart';
import 'package:zxvision1/data/repository/popular_product_repo.dart';
import 'package:zxvision1/utils/app_constants.dart';

import '../controllers/recommended_product_controller.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));
  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
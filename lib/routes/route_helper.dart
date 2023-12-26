import 'package:get/get.dart';
import 'package:zxvision1/models/order_model.dart';
import 'package:zxvision1/pages/address/add_new_address_page.dart';
import 'package:zxvision1/pages/auth/signin_page.dart';
import 'package:zxvision1/pages/cart/cart_page.dart';
import 'package:zxvision1/pages/food/popular_food_detail.dart';
import 'package:zxvision1/pages/food/recommended_food_detail.dart';
import 'package:zxvision1/pages/home/home_page.dart';
import 'package:zxvision1/pages/payment/payment_screen_page.dart';
import 'package:zxvision1/pages/splash/splash_page.dart';

import '../pages/address/pick_new_address_map.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial="/";
  static const String popularFood="/popular-food";
  static const String recommendedFood="/recommended-food";
  static const String cartPage="/cart-page";
  static const String login="/login-page";
  static const String addAddress="/add-address";
  static const String pickAddressMap="/pick-address";
  static const String payment='/payment';
  static const String orderSuccess='/order-successful';

  static String getSplashPage()=>'$splashPage';
  static String getInitial()=>'$initial';
  static String getPopularFood(int pageId, String page)=>'$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page)=>'$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage()=>'$cartPage';
  static String getLoginPage()=>'$login';
  static String getAddressPage()=>'$addAddress';
  static String getPickAddressPage()=>'$pickAddressMap';
  static String getPaymentPage(String id, String userId)=>'$payment?id=$id&userID=$userId';
  static String getOrderSuccessPage()=>'$orderSuccess';

  static List<GetPage> routes = [
    GetPage(name: login, page: ()=>SignInPage(), transition: Transition.fade),
    GetPage(name: splashPage, page: ()=>SplashPage()),
    GetPage(name: initial, page: ()=>HomePage()),
    GetPage(
        name: popularFood,
        page: (){
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn,
    ),
    GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn,
    ),
    GetPage(name: cartPage, page: () {return CartPage();}, transition: Transition.fadeIn),
    GetPage(name: addAddress, page: () {return AddNewAddressPage();}, transition: Transition.fadeIn),
    GetPage(name: pickAddressMap, page: (){
      PickNewAddressMap _pickAddress = Get.arguments;
      return _pickAddress;
    }),
    GetPage(name: payment, page: ()=>PaymentScreen(
        orderModel: OrderModel(
          id: int.parse(Get.parameters['id']!),
          userId: int.parse(Get.parameters['userID']!),
        ))),
    // GetPage(name: orderSuccess, page: ()=>Order)
  ];
}
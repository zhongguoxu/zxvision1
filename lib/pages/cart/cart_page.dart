import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zxvision1/base/common_text_button.dart';
import 'package:zxvision1/base/no_data_page.dart';
import 'package:zxvision1/controllers/auth_controller.dart';
import 'package:zxvision1/controllers/cart_controller.dart';
import 'package:zxvision1/controllers/location_controller.dart';
import 'package:zxvision1/controllers/order_controller.dart';
import 'package:zxvision1/controllers/popular_product_controller.dart';
import 'package:zxvision1/controllers/user_controller.dart';
import 'package:zxvision1/models/place_order_model.dart';
import 'package:zxvision1/pages/home/main_food_page.dart';
import 'package:zxvision1/pages/order/widgets/delivery_options.dart';
import 'package:zxvision1/routes/route_helper.dart';
import 'package:zxvision1/utils/app_constants.dart';
import 'package:zxvision1/utils/colors.dart';
import 'package:zxvision1/utils/dimensions.dart';
import 'package:zxvision1/widgets/app_icon.dart';
import 'package:zxvision1/widgets/app_text_field.dart';
import 'package:zxvision1/widgets/big_text.dart';
import 'package:zxvision1/pages/order/widgets/payment_option_button.dart';
import 'package:zxvision1/widgets/small_text.dart';

import '../../controllers/recommended_product_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          //header
          Positioned(
              top: Dimensions.height20*3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: AppIcon(icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                    onTap: () => Get.back(),
                  ),
                  // SizedBox(width: Dimensions.width20*5,),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  // AppIcon(icon: Icons.shopping_cart,
                  //   iconColor: Colors.white,
                  //   backgroundColor: AppColors.mainColor,
                  //   iconSize: Dimensions.iconSize24,
                  // )
                ],
              )
          ),
          //body
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItems.length >0 ? Positioned(
              top: Dimensions.height20*5,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
              child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height15),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(builder: (cartController) {
                      var _cartList = cartController.getItems;
                      return ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_, index) {
                            var hasExtraFee = _cartList[index].envFee! > 0 || _cartList[index].serviceFee! > 0;
                            var hasEnvFee = _cartList[index].envFee! > 0;
                            var hasServiceFee = _cartList[index].serviceFee! > 0;
                            return Container(
                              // height: 100,
                              // width: double.maxFinite,
                              // margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height10),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // var popularIndex = Get.find<PopularProductController>().popularProductList.indexOf(_cartList[index].product!);
                                      // if (popularIndex >= 0) {
                                      //   Get.toNamed(RouteHelper.getPopularFood(popularIndex, "cartPage"));
                                      // } else {
                                      //   var recommendedIndex = Get.find<RecommendedProductController>().recommendedProductList.indexOf(_cartList[index].product!);
                                      //   if (recommendedIndex<0) {
                                      //     Get.snackbar("History product", "Product review is not available for history product!",
                                      //       backgroundColor: AppColors.mainColor,
                                      //       colorText: Colors.white,
                                      //     );
                                      //   } else {
                                      //     Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex, "cartPage"));
                                      //   }
                                      // }
                                    },
                                    child: Container(
                                      width: Dimensions.listViewImgSize * 0.75,
                                      height: Dimensions.listViewImgSize * 0.75,
                                      // margin: EdgeInsets.only(bottom: Dimensions.height10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                                        color: Colors.white38,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            AppConstants.BASE_URL+AppConstants.UPLOAD_URL+_cartList[index].img!,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(width: Dimensions.width10,),
                                  // Expanded(child: Container(
                                  //   height: Dimensions.height20*5,
                                  //   child: Column(
                                  //     crossAxisAlignment: CrossAxisAlignment.start,
                                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //     children: [
                                  //       BigText(text: _cartList[index].name!, color: Colors.black54,),
                                  //       SmallText(text: "Spicy"),
                                  //       Row(
                                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //         children: [
                                  //           BigText(text: "\$ ${_cartList[index].price!}", color: Colors.redAccent,),
                                  //           Container(
                                  //             padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10, left: Dimensions.width10, right: Dimensions.width10),
                                  //             decoration: BoxDecoration(
                                  //               borderRadius: BorderRadius.circular(Dimensions.radius20),
                                  //               color: Colors.white,
                                  //             ),
                                  //             child: Row(
                                  //               children: [
                                  //                 GestureDetector(
                                  //                   onTap: () {
                                  //                     cartController.addItemFromCart(_cartList[index].id!, -1);
                                  //                     // popularProductController.setQuantity(false);
                                  //                   },
                                  //                   child: Icon(Icons.remove, color: AppColors.signColor,),
                                  //                 ),
                                  //                 SizedBox(width: Dimensions.width10,),
                                  //                 BigText(text: _cartList[index].quantity.toString()),//popularProductController.inCartItems.toString()
                                  //                 SizedBox(width: Dimensions.width10,),
                                  //                 GestureDetector(
                                  //                   onTap: () {
                                  //                     cartController.addItemFromCart(_cartList[index].id!, 1);
                                  //                     // popularProductController.setQuantity(true);
                                  //                   },
                                  //                   child: Icon(Icons.add, color: AppColors.signColor,),
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       )
                                  //     ],
                                  //   ),
                                  // )),
                                  Expanded(
                                    child: Container(
                                      height: Dimensions.listViewTextContainerSize,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.radius20), bottomRight: Radius.circular(Dimensions.radius20)),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            BigText(text: _cartList[index].name!),
                                            SizedBox(height: hasExtraFee ? Dimensions.height10/4 : Dimensions.height10,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                BigText(text: 'x'+_cartList[index].quantity!.toString(), color: Theme.of(context).disabledColor,),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartController.addItemFromCart(_cartList[index].id!, -1);
                                                        // popularProductController.setQuantity(false);
                                                      },
                                                      child: Icon(Icons.remove, color: AppColors.signColor,),
                                                    ),
                                                    SizedBox(width: Dimensions.width10,),
                                                    BigText(text: _cartList[index].quantity.toString()),//popularProductController.inCartItems.toString()
                                                    SizedBox(width: Dimensions.width10,),
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartController.addItemFromCart(_cartList[index].id!, 1);
                                                        // popularProductController.setQuantity(true);
                                                      },
                                                      child: Icon(Icons.add, color: AppColors.signColor,),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(height: hasExtraFee ? Dimensions.height10/4 : Dimensions.height10,),
                                            BigText(text: '\$'+_cartList[index].price!.toString()),
                                            hasExtraFee ? SizedBox(height: Dimensions.height10/4,) : Container(),
                                            hasExtraFee ?
                                              Row(
                                                children: [
                                                  hasEnvFee ? SmallText(text: 'Deposit: \$'+_cartList[index].envFee!.toStringAsFixed(2), size: Dimensions.font16/2*1.5,) : Container(),
                                                  hasEnvFee ? SizedBox(width: Dimensions.width10,) : Container(),
                                                  hasServiceFee ? SmallText(text: 'Service: \$'+(_cartList[index].price!*_cartList[index].serviceFee!).toStringAsFixed(2), size: Dimensions.font16/2*1.5,) : Container(),
                                                ],
                                              ) : Container(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },),)
              ),
            ) : NoDataPage(text: "Cart is empty!");
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (cartController) {
        _noteController.text = cartController.orderNote;
        return GetBuilder<CartController>(builder: (cartController) {
          return Container(
              height: Dimensions.bottomHeightBar+50,
              padding: EdgeInsets.only(
                  top: Dimensions.height10,
                  bottom: Dimensions.height10,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20*2),
                    topRight: Radius.circular(Dimensions.radius20*2),
                  )
              ),
              child: cartController.getItems.length > 0 ? Column(
                children: [
                  InkWell(
                    onTap: ()=>showModalBottomSheet(
                        backgroundColor: Colors.transparent, // default is white, which makes the border radius unvisible
                        context: context,
                        builder: (_){
                          return Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView( // if there is overflow issue, wrap Single by Column -> Expanded -> Single
                                  child: Container(
                                    height: MediaQuery.of(context).size.height*0.9,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(Dimensions.radius20),
                                          topRight: Radius.circular(Dimensions.radius20),
                                        )
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 550,
                                          padding: EdgeInsets.only(
                                              left: Dimensions.width20,
                                              right: Dimensions.width20,
                                              top: Dimensions.height20
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const PaymentOptionButton(
                                                icon: Icons.money,
                                                title: 'Cash',
                                                subTitle: 'Pay after getting the delivery',
                                                index: 0,
                                              ),
                                              SizedBox(height: Dimensions.height10,),
                                              const PaymentOptionButton(
                                                icon: Icons.paypal_outlined,
                                                title: 'Online',
                                                subTitle: 'Safer and faster payment',
                                                index: 1,
                                              ),
                                              SizedBox(height: Dimensions.height20,),
                                              Text("Delivery options", style: TextStyle(fontSize: Dimensions.font26),),
                                              DeliveryOptions(
                                                  value: "delivery",
                                                  title: "Home delivery",
                                                  amount: Get.find<CartController>().totalAmout,
                                                  isFree: false
                                              ),
                                              SizedBox(height: Dimensions.height10,),
                                              const DeliveryOptions(
                                                  value: "carry out",
                                                  title: "Carry out",
                                                  amount: 0,
                                                  isFree: true
                                              ),
                                              SizedBox(
                                                height: Dimensions.height20,
                                              ),
                                              Text(
                                                'Additional notes',
                                                style: TextStyle(fontSize: Dimensions.font26),
                                              ),
                                              AppTextField(
                                                textController: _noteController,
                                                hintText: '',
                                                icon: Icons.note,
                                                maxLines: true,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                    ).whenComplete(() {
                      cartController.setOrderNote(_noteController.text.trim());
                    }),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: CommonTextButton(text: "payment options",),
                    ),
                  ),
                  SizedBox(height: Dimensions.height10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: Dimensions.width10,),
                            BigText(text: "\$ "+cartController.totalAmout.toStringAsFixed(2)),
                            SizedBox(width: Dimensions.width10,),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if(Get.find<UserController>().userHasLoggedIn()) {
                            // var canPlaceOrder = false;
                            if (Get.find<UserController>().userModel == null) {
                              Get.find<UserController>().getUserInfo().then((_) {
                                if (Get.find<UserController>().addressList.isEmpty) {
                                  Get.find<UserController>().getUserAddressList(Get.find<UserController>().userModel!.id).then((_) {
                                    if (Get.find<UserController>().addressList.isEmpty) {
                                      Get.toNamed(RouteHelper.getAddressPage());
                                    } else {
                                      print("zack this is true 1");
                                      Get.toNamed(RouteHelper.getOrderReviewPage());
                                    }
                                  });
                                } else {
                                  Get.toNamed(RouteHelper.getOrderReviewPage());
                                }
                              });
                            } else {
                              if (Get.find<UserController>().addressList.isEmpty) {
                                Get.find<UserController>().getUserAddressList(Get.find<UserController>().userModel!.id).then((_) {
                                  if (Get.find<UserController>().addressList.isEmpty) {
                                    Get.toNamed(RouteHelper.getAddressPage());
                                  } else {
                                    print("zack this is true 2");
                                    Get.toNamed(RouteHelper.getOrderReviewPage());
                                  }
                                });
                              } else {
                                print("zack this is true 3");
                                Get.toNamed(RouteHelper.getOrderReviewPage());
                              }
                            }
                          } else {
                            Get.toNamed(RouteHelper.getLoginPage());
                          }
                        },
                        child: CommonTextButton(text: "checkout",),
                      )
                    ],
                  ) ,
                ],
              ) : Container()
          );
        },);
      })
    );
  }
}

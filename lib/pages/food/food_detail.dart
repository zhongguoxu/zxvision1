import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zxvision1/controllers/cart_controller.dart';
import 'package:zxvision1/controllers/food_type_controller.dart';
import 'package:zxvision1/controllers/popular_product_controller.dart';
import 'package:zxvision1/controllers/recommended_product_controller.dart';
import 'package:zxvision1/models/products_model.dart';
import 'package:zxvision1/pages/cart/cart_page.dart';
import 'package:zxvision1/pages/home/main_food_page.dart';
import 'package:zxvision1/routes/route_helper.dart';
import 'package:zxvision1/utils/app_constants.dart';
import 'package:zxvision1/utils/dimensions.dart';
import 'package:zxvision1/widgets/app_column.dart';
import 'package:zxvision1/widgets/app_icon.dart';
import 'package:zxvision1/widgets/expandable_text.dart';

import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/small_text.dart';

class FoodDetail extends StatelessWidget {
  final int foodId;
  final String page;
  final int typeId;
  const FoodDetail({Key? key, required this.foodId, required this.page, required this.typeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = ProductModel();
    if (page == "popular") {
      product = Get.find<PopularProductController>().popularProductList[foodId];
    }
    if (page == "recommend") {
      product = Get.find<RecommendedProductController>().recommendedProductList[foodId];
    }
    if (page == "type") {
      product = Get.find<FoodTypeController>().foodPerTypeList[foodId];
    }
    Get.find<PopularProductController>().initProduct(Get.find<CartController>(), product);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // background img
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
                        )
                    )
                ),
              )),
          // icon widget
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // if (page == "cartPage") {
                      //   Get.toNamed(RouteHelper.getCartPage());
                      // } else {
                        if (page == "type") {
                          Get.toNamed(RouteHelper.getFoodTypePage(typeId));
                        } else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      // }
                    },
                    child: AppIcon(icon: Icons.arrow_back_ios),
                  ),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.totalItems > 0) {
                          Get.toNamed(RouteHelper.getCartPage());
                        }
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                          controller.totalItems > 0 ? Positioned(
                            right: 0, top: 0,
                            child: AppIcon(icon: Icons.circle, size: 20, iconColor: Colors.transparent,backgroundColor: AppColors.mainColor,),
                          ) : Container(

                          ),
                          controller.totalItems > 0 ? Positioned(
                            right: 3, top: 3,
                            child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),size: 12, color: Colors.white,),
                          ) : Container(

                          ),
                        ],
                      ),
                    );
                  }),
                ],
              )
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize-Dimensions.height20,
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: "Introduce"),
                    SizedBox(height: Dimensions.height20,),
                    Expanded(
                        child: SingleChildScrollView(
                            child: ExpandableTextWidget(text: product.description!)))
                  ],
                ),
              )
          ),

        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularProductController) {
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20*2),
                topRight: Radius.circular(Dimensions.radius20*2),
              )
          ),
          child: Row(
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
                    GestureDetector(
                      onTap: () {
                        popularProductController.setQuantity(false);
                      },
                      child: Icon(Icons.remove, color: AppColors.signColor,),
                    ),
                    SizedBox(width: Dimensions.width10,),
                    BigText(text: popularProductController.inCartItems.toString()),
                    SizedBox(width: Dimensions.width10,),
                    GestureDetector(
                      onTap: () {
                        popularProductController.setQuantity(true);
                      },
                      child: Icon(Icons.add, color: AppColors.signColor,),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  popularProductController.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                  child: BigText(text: "\$ ${product.price} | Add to cart", color: Colors.white,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                ),
              )
            ],
          ),
        );
      },),
    );
  }
}

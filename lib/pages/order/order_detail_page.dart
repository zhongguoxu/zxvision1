import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zxvision1/controllers/order_controller.dart';
import 'package:zxvision1/models/cart_model.dart';
import 'package:zxvision1/models/place_order_model.dart';
import 'package:zxvision1/pages/order/order_detail_item.dart';
import 'package:zxvision1/utils/app_constants.dart';
import 'package:zxvision1/utils/colors.dart';
import 'package:zxvision1/utils/dimensions.dart';
import 'package:zxvision1/widgets/big_text.dart';
import 'package:get/get.dart';

class OrderDetailPage extends StatelessWidget {
  final int orderIndex;
  final String isCurrent;
  const OrderDetailPage({Key? key, required this.orderIndex, required this.isCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(text: "Order Details", color: Colors.white,),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<OrderController>(builder: (orderController) {
          PlaceOrderBody thisOrder = isCurrent == "current" ? orderController.currentOrderList[orderIndex] : orderController.historyOrderList[orderIndex];
          List<CartModel> products = orderController.parseStringToProductList(thisOrder.products);
          return Column(
            children: [
              SizedBox(
                height: Dimensions.height10,
              ),
              isCurrent == "current" ? Container(
                height: Dimensions.height20*2,
                child: Text(
                  orderController.getOrderStatus(thisOrder.orderStatus),
                  style: TextStyle(fontSize: Dimensions.font20, color: Colors.red),
                  overflow: TextOverflow.ellipsis,
                ),
              ) : SizedBox(),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => null,
                    child: Container(
                      margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, bottom: Dimensions.height10),
                      child: Row(
                        children: [
                          //Image section
                          Container(
                            width: Dimensions.listViewImgSize * 0.75,
                            height: Dimensions.listViewImgSize * 0.75,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white38,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      AppConstants.BASE_URL+AppConstants.UPLOAD_URL+products[index].img!,
                                    )
                                )
                            ),
                          ),
                          //text container
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
                                    BigText(text: products[index].name!),
                                    SizedBox(height: Dimensions.height10,),
                                    BigText(text: 'x'+products[index].quantity!.toString(), color: Theme.of(context).disabledColor,),
                                    SizedBox(height: Dimensions.height10,),
                                    BigText(text: '\$'+products[index].price!.toString()),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              OrderDetailItem(itemName: "Order ID", itemValue: thisOrder.orderId),
              OrderDetailItem(itemName: "Placed date", itemValue: thisOrder.createdTime),
              OrderDetailItem(itemName: "Payment", itemValue: thisOrder.paymentMethod),
              OrderDetailItem(itemName: "Subtotal", itemValue: '\$'+thisOrder.subTotal),
              OrderDetailItem(itemName: "Tax", itemValue: '\$'+thisOrder.tax),
              OrderDetailItem(itemName: "Tips", itemValue: '\$'+thisOrder.tips),
              OrderDetailItem(itemName: "Total", itemValue: '\$'+thisOrder.total),
              OrderDetailItem(itemName: "Remarks", itemValue: thisOrder.remarks),
              SizedBox(height: Dimensions.height30,)
            ],
          );
        },),
      ),
    );
  }
}

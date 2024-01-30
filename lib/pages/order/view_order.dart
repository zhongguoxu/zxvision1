import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zxvision1/base/custom_loader.dart';
import 'package:zxvision1/controllers/order_controller.dart';
import 'package:zxvision1/models/place_order_model.dart';
import 'package:zxvision1/utils/colors.dart';
import 'package:zxvision1/utils/dimensions.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;
  const ViewOrder({Key? key, required this.isCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(builder: (orderController) {
        if (orderController.isLoading == false) {
          List<PlaceOrderBody> orderList = [];
          if (isCurrent) {
            if (orderController.currentOrderList.isNotEmpty) {
              orderList = orderController.currentOrderList.reversed.toList();
            }
          } else {
            if (orderController.historyOrderList.isNotEmpty) {
              orderList = orderController.currentOrderList.reversed.toList();
            }
          }
          return SizedBox(
            width: Dimensions.screenWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10/2, vertical: Dimensions.height10),
              child: ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () => null,
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text("order ID:"),
                                      SizedBox(width: Dimensions.width10/2,),
                                      Text(orderList[index].orderId)
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        child: Container(
                                          margin: EdgeInsets.all(Dimensions.height10/2),
                                          child: Text('${orderList[index].orderStatus}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: Dimensions.font16*0.75,
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.mainColor,
                                          borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                                        ),
                                      ),
                                      SizedBox(height: Dimensions.height10/2,),
                                      InkWell(
                                        onTap: () => null,
                                        child: Container(
                                          // margin: EdgeInsets.symmetric(horizontal: Dimensions.width10/2),
                                          height: Dimensions.height30,
                                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,vertical: Dimensions.height10/2),
                                          child: Row(
                                            children: [
                                              Image.asset("assets/image/test3.png", height: 15, width: 15, color: Theme.of(context).primaryColor,), // use tracking.png
                                              SizedBox(width: Dimensions.width10/2,),
                                              Text("Track order"),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                                            border: Border.all(width: 1, color: Theme.of(context).primaryColor),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: Dimensions.height10,)
                          ],
                        )
                    );
                  }),
            ),
          );
        } else {
          return CustomLoader();
        }
      }),
    );
  }
}

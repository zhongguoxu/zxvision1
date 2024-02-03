import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zxvision1/controllers/order_controller.dart';
import 'package:zxvision1/utils/dimensions.dart';

class DeliveryOptions extends StatelessWidget {
  final String value;
  final String title;
  final double amount;
  final bool isFree;
  const DeliveryOptions({Key? key,
    required this.value,
    required this.title,
    required this.amount,
    required this.isFree,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return Row(
        children: [
          Radio(
            value: value,
            groupValue: orderController.deliveryType,
            onChanged: (String? value) {
              orderController.setDeliveryType(value!);
              print(value.toString());
            },
            activeColor: Theme.of(context).primaryColor,
          ),
          SizedBox(
            width: Dimensions.width10/2,
          ),
          Text(
            title,
            style: TextStyle(fontSize: Dimensions.font20),
          ),
          SizedBox(
            width: Dimensions.width10/2,
          ),
          Text(isFree ? '(Free)':'(\$${amount/10})', style: TextStyle(fontSize: Dimensions.font20),),
        ],
      );
    });
  }
}

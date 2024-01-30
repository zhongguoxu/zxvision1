import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:zxvision1/base/custom_app_bar.dart';
import 'package:zxvision1/controllers/order_controller.dart';
import 'package:zxvision1/controllers/user_controller.dart';
import 'package:zxvision1/pages/order/view_order.dart';
import 'package:zxvision1/utils/colors.dart';

import '../../utils/dimensions.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = Get.find<UserController>().userHasLoggedIn();
    if (_isLoggedIn) {
      _tabController = TabController(length: 2, vsync: this);
      if (Get.find<UserController>().userModel == null) {
        Get.find<UserController>().getUserInfo().then((_) {
          Get.find<OrderController>().getOrderList(Get.find<UserController>().userModel!.phone);
        });
      } else {
        Get.find<OrderController>().getOrderList(Get.find<UserController>().userModel!.phone);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "My Orders",
      ),
      body: Column(
        children: [
          Container(
            width: Dimensions.screenWidth,
            child: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              indicatorWeight: 3,
              unselectedLabelColor: Theme.of(context).disabledColor,
              controller: _tabController,
              tabs: [
                Tab(text: "current",),
                Tab(text: "history",)
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ViewOrder(isCurrent: true),
                ViewOrder(isCurrent: false)
              ],
            ),
          )
        ],
      ),
    );
  }
}


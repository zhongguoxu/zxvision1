import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zxvision1/controllers/location_controller.dart';
import 'package:zxvision1/controllers/user_controller.dart';
import 'package:zxvision1/pages/address/address_constants.dart';
import 'package:zxvision1/utils/app_constants.dart';
import 'package:zxvision1/utils/colors.dart';
import 'package:zxvision1/utils/dimensions.dart';
import 'package:zxvision1/widgets/app_text_field.dart';
import 'package:zxvision1/widgets/big_text.dart';

class AddNewAddressPage extends StatefulWidget {
  const AddNewAddressPage({Key? key}) : super(key: key);

  @override
  _AddNewAddressPageState createState() => _AddNewAddressPageState();
}

class _AddNewAddressPageState extends State<AddNewAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  final CameraPosition _cameraPosition = const CameraPosition(target: LatLng(AddressConstants.lat, AddressConstants.lng));
  LatLng _initialPosition = const LatLng(AddressConstants.lat, AddressConstants.lng);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Get.find<UserController>().addressList.isEmpty) {
      Get.find<UserController>().getUserAddressList(Get.find<UserController>().userModel!.id);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AddressConstants.title),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        _contactPersonName.text='${userController.userModel?.name}';
        _contactPersonNumber.text='${userController.userModel?.phone}';
        if(userController.addressList.isEmpty) {
          _addressController.text = AddressConstants.address;
          // userController.getUserAddressList(userController.userModel!.id).then((_) {
          //   if (userController.addressList.isNotEmpty) {
          //     // print("get address list from server");
          //     _initialPosition = LatLng(double.parse(userController.addressList.last.latitude), double.parse(userController.addressList.last.longituge));
          //     _addressController.text = userController.addressList.last.address;
          //   } else {
          //     // print("get empty address list from server");
          //     // _initialPosition 无需update
          //     _addressController.text = AddressConstants.address;
          //   }
          // });
        } else {
          _initialPosition = LatLng(double.parse(userController.addressList.last.latitude), double.parse(userController.addressList.last.longituge));
          _addressController.text = userController.addressList.last.address;
        }
        return GetBuilder<LocationController>(builder: (locationController) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Dimensions.height20*7,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 5,right: 5,top: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 2,
                        color: AppColors.mainColor,
                      )
                  ),
                  child: Stack(
                    children: [
                      GoogleMap(initialCameraPosition: CameraPosition(target: _initialPosition, zoom: AddressConstants.zoom_in)),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height15,),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Delivery Address"),
                ),
                SizedBox(height: Dimensions.height10,),
                AppTextField(textController: _addressController, hintText: "Your address", icon: Icons.map),
                SizedBox(height: Dimensions.height15,),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Contact me"),
                ),
                SizedBox(height: Dimensions.height10,),
                AppTextField(textController: _contactPersonName, hintText: "Your name", icon: Icons.person),
                SizedBox(height: Dimensions.height15,),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Your number"),
                ),
                SizedBox(height: Dimensions.height10,),
                AppTextField(textController: _contactPersonNumber, hintText: "Your phone", icon: Icons.phone),
              ],
            ),
          );
        });
      }),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: Dimensions.height20*5,
            padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10, left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20*2),
                  topRight: Radius.circular(Dimensions.radius20*2),
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                  child: BigText(text: "Save address", color: Colors.white, size: 20,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}


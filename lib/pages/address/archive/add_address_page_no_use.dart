import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zxvision1/controllers/auth_controller.dart';
import 'package:zxvision1/controllers/location_controller.dart';
import 'package:zxvision1/controllers/user_controller.dart';
import 'package:zxvision1/models/address_model.dart';
import 'package:zxvision1/pages/address/archive/pick_address_map.dart';
import 'package:zxvision1/routes/route_helper.dart';
import 'package:zxvision1/utils/app_constants.dart';
import 'package:zxvision1/utils/colors.dart';
import 'package:zxvision1/utils/dimensions.dart';
import 'package:zxvision1/widgets/app_text_field.dart';
import 'package:zxvision1/widgets/big_text.dart';

import '../../../widgets/app_icon.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition = const CameraPosition(target: LatLng(
      53.5461,-113.4937
  ), zoom: 17);
  LatLng _initialPosition=LatLng(
      53.5461,-113.4937
  );
  @override void initState() {
    // TODO: implement initState
    super.initState();
    _isLogged = Get.find<AuthController>().userHasLoggedIn();
    if (_isLogged&&Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    print("address list : "+Get.find<LocationController>().addressList.toString());
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if (Get.find<LocationController>().getUserAddressFromLocalStorage()=="") {
        Get.find<LocationController>().saveUserAddress(
            Get.find<LocationController>().addressList.last
        );
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition=CameraPosition(target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      ));
      _initialPosition=LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address page"),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        if(userController.userModel!=null&&_contactPersonName.text.isEmpty) {
          _contactPersonName.text='${userController.userModel?.name}';
          _contactPersonNumber.text='${userController.userModel?.phone}';
          if(Get.find<LocationController>().addressList.isNotEmpty) {
            _addressController.text = Get.find<LocationController>().getUserAddress().address;
          }
        }
        return GetBuilder<LocationController>(builder: (locationController) {
          print("placemark "+locationController.placemark.toString());
          _addressController.text='${locationController.placemark.name??''}'
              '${locationController.placemark.locality??''}'
              '${locationController.placemark.postalCode??''}'
              '${locationController.placemark.country??''}';
          print("address in my view is "+_addressController.text);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140,
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
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: _initialPosition, zoom: AppConstants.ZOOM_IN,
                        ),
                        onTap: (latlng) {
                          Get.toNamed(RouteHelper.getPickAddressPage(),
                            arguments: PickAddressMap(
                              fromSignup: false,
                              fromAddress: true,
                              googleMapController: locationController.mapController,
                            )
                          );
                        },
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        myLocationEnabled: true,
                        onCameraIdle: (){
                          locationController.updatePosition(_cameraPosition, true);
                        },
                        onCameraMove: ((position)=>_cameraPosition=position),
                        onMapCreated: (GoogleMapController controller) {
                          locationController.setMapController(controller);
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20,top: Dimensions.height20),
                  child: SizedBox(height: 50,child: ListView.builder(itemCount: locationController.addressTypeList.length,shrinkWrap: true,scrollDirection: Axis.horizontal,itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        locationController.setAddressTypeIndex(index);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,vertical: Dimensions.height10),
                        margin: EdgeInsets.only(right: Dimensions.width10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20/4),
                          color: Theme.of(context).cardColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200]!,
                              spreadRadius: 1,
                              blurRadius: 5,
                            )
                          ],
                        ),
                        child: Icon(
                          index==0 ? Icons.home_filled:index==1?Icons.work:Icons.location_on,
                          color: locationController.addressTypeIndex==index?AppColors.mainColor:Theme.of(context).disabledColor,
                        ),
                      ),
                    );
                  })),
                ),
                SizedBox(height: Dimensions.height20,),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Delivery Address"),
                ),
                SizedBox(height: Dimensions.height10,),
                AppTextField(textController: _addressController, hintText: "Your address", icon: Icons.map),
                SizedBox(height: Dimensions.height20,),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Contact me"),
                ),
                SizedBox(height: Dimensions.height10,),
                AppTextField(textController: _contactPersonName, hintText: "Your name", icon: Icons.person),
                SizedBox(height: Dimensions.height20,),
                Padding(
                  padding: EdgeInsets.only(left: Dimensions.width20),
                  child: BigText(text: "Your number"),
                ),
                SizedBox(height: Dimensions.height10,),
                AppTextField(textController: _contactPersonNumber, hintText: "Your phone", icon: Icons.phone),
              ],
            ),
          );
        },);
      },),
      bottomNavigationBar: GetBuilder<LocationController>(builder: (controller) {
        return Column(
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
                  GestureDetector(
                    onTap: () {
                      // controller.addItem(product);
                      AddressModel _addressModel = AddressModel(
                        addressType: controller.addressTypeList[controller.addressTypeIndex],
                        contactPersonName: _contactPersonName.text,
                        contactPersonNumber: _contactPersonNumber.text,
                        address: _addressController.text,
                        latitude: controller.position.latitude.toString(),
                        longitude: controller.position.longitude.toString(),
                      );
                      controller.addAddress(_addressModel).then((value) {
                        if (value.isSuccess) {
                          // Get.back();
                          Get.offNamed(RouteHelper.getInitial());
                          Get.snackbar("Address", "Added successfully");
                        } else {
                          Get.snackbar("Address", "Couldn't save address");
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                      child: BigText(text: "Save address", color: Colors.white, size: 20,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },),
    );
  }
}

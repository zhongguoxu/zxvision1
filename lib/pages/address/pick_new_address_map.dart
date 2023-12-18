import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zxvision1/controllers/user_controller.dart';
import 'package:zxvision1/pages/address/address_constants.dart';
import 'package:zxvision1/pages/address/widgets/search_location_page.dart';

import '../../base/custom_button.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class PickNewAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final  GoogleMapController? googleMapController;
  const PickNewAddressMap({Key? key, required this.fromSignup, required this.fromAddress, this.googleMapController}) : super(key: key);

  @override
  _PickNewAddressMapState createState() => _PickNewAddressMapState();
}

class _PickNewAddressMapState extends State<PickNewAddressMap> {
  late GoogleMapController _mapController;
  late LatLng _initialPosition;
  late CameraPosition _cameraPosition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _initialPosition = LatLng(double.parse(Get.find<UserController>().currentAddress!.latitude), double.parse(Get.find<UserController>().currentAddress!.longituge));
    _initialPosition = LatLng(double.parse(Get.find<UserController>().dynamicAddress!.latitude), double.parse(Get.find<UserController>().dynamicAddress!.longituge));
    _cameraPosition = CameraPosition(target: _initialPosition, zoom: AddressConstants.zoom_in);
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: _initialPosition,
                        zoom: AddressConstants.zoom_in),
                    onMapCreated: (GoogleMapController mapController) {
                      _mapController = mapController;
                    },
                    zoomControlsEnabled: false,
                    onCameraMove: (CameraPosition cameraPosition) {_cameraPosition=cameraPosition;},
                    onCameraIdle: () {Get.find<UserController>().updatePosition(_cameraPosition);},
                  ),
                  Center(
                    // child: Image.asset("assets/image/pick_marker.png", height: 50, width: 50,),
                    child: !userController.isLoading ?
                    Image.asset("assets/image/pick_marker.png", height: 50, width: 50,) :
                    CircularProgressIndicator(),
                  ),
                  Positioned(
                      top: Dimensions.height45,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      child: InkWell(
                        onTap: () => Get.dialog(LocationDialogue(mapController: _mapController)),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width10),
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(
                                Dimensions.radius20 / 2),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.location_on, size: 25,
                                color: AppColors.yellowColor,),
                              Expanded(
                                child: Text(
                                  // userController.currentAddress!.address,
                                  userController.dynamicAddress!.address,
                                  style: TextStyle(color: Colors.white, fontSize: Dimensions.font16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: Dimensions.width10,),
                              Icon(Icons.search, size: 25,
                                color: AppColors.yellowColor,),
                            ],
                          ),
                        ),
                      )
                  ),
                  Positioned(
                      bottom: 80,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      child: userController.isLoading ? Center(child: CircularProgressIndicator(),) : CustomButton(
                        buttonText: AddressConstants.pick_new_address,
                        onPressed: () {
                          if(widget.fromAddress) {
                            widget.googleMapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
                                target:
                            LatLng(double.parse(userController.dynamicAddress!.latitude),double.parse(userController.dynamicAddress!.longituge)),
                                // LatLng(double.parse(userController.currentAddress!.latitude),double.parse(userController.currentAddress!.longituge)),
                            zoom: AddressConstants.zoom_in)));
                            // userController.setAddAddressData();
                            Get.back();
                          } else { // TODO: from signup

                          }
                        },
                      )
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

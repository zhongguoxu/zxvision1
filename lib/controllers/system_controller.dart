
import 'dart:convert';

import 'package:get/get.dart';
import 'package:zxvision1/data/repository/system_repo.dart';
import 'package:zxvision1/models/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:zxvision1/models/system_model.dart';

class SystemController extends GetxController {
  final SystemRepo systemRepo;

  SystemController({required this.systemRepo});

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  List<SystemModel> _systemInfo = [];
  List<SystemModel> get systemInfo=>_systemInfo;

  Future<void> getSystemInfo() async {
    http.Response response = await systemRepo.getSystemInfo();
    if (response.statusCode == 200) {
      _systemInfo = [];
      _systemInfo.addAll(SystemModelList.fromJson(jsonDecode(response.body)).systemModelList);
      // _popularProductList.addAll(Product.fromJson(jsonDecode(response.body)).products);
      // print("zack get system info successfully");
      _isLoaded = true;
      update();
    } else {

    }
  }
}
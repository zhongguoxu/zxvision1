import 'dart:convert';

import 'package:get/get.dart';
import 'package:zxvision1/data/repository/food_type_repo.dart';
import 'package:zxvision1/models/products_model.dart';
import '../data/repository/recommended_product_repo.dart';
import 'package:http/http.dart' as http;

class FoodTypeController extends GetxController {
  final FoodTypeRepo foodTypeRepo;
  FoodTypeController({required this.foodTypeRepo});
  List<dynamic> _foodPerTypeList = []; // underscore means private variable
  List<dynamic> get foodPerTypeList => _foodPerTypeList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  Future<void> getFoodPerTypeProductList(int typeId) async {
    http.Response response = await foodTypeRepo.getFoodProductListPerType(typeId);
    if (response.statusCode==200) { // most http call return 200 for successful response
      _foodPerTypeList = [];
      _foodPerTypeList.addAll(Product.fromJson(jsonDecode(response.body)).products);
      _isLoaded = true;
      print("zack get list "+ _foodPerTypeList.length.toString());
      update();
    } else {
      print('could not got this type products');
    }
  }
}
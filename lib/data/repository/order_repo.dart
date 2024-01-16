import 'package:zxvision1/data/api/http_client.dart';
import 'package:zxvision1/models/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:zxvision1/models/place_order_model.dart';

import '../../utils/app_constants.dart';

class OrderRepo {
  final HttpClient httpClient;
  OrderRepo({required this.httpClient});

  Future<http.Response> placeOrder(PlaceOrderBody placeOrderBody) async {
    var newJson = placeOrderBody.toJson();
    print(newJson);
    // newJson.putIfAbsent("user_id", () => UserModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.USER_ACCOUNT)!)).id);
    // newJson.putIfAbsent("created_at", () => DateTime.now().toString());
    // newJson.putIfAbsent("updated_at", () => DateTime.now().toString());
    return await httpClient.postData(AppConstants.PLACE_ORDER_URL, newJson);
  }
}
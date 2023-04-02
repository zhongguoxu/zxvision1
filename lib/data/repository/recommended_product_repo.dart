import 'package:get/get.dart';
import 'package:zxvision1/data/api/api_client.dart';
import 'package:zxvision1/utils/app_constants.dart';

class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});
  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}
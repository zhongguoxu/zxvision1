class AppConstants {
  static const String APP_NAME = "DBFood";
  static const int APP_VERSION = 1;

  // static const String BASE_URL = "http://mvs.bslmeiyu.com";
  static const String BASE_URL = "https://jayu.tech/shopping-app";
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";
  static const String UPLOAD_URL = "/";
  static const String TOKEN = "";
  static const String PHONE = "";
  static const String PASSWORD = "";
  static const String CART_LIST = "Cart-list";
  static const String CART_HISTORY_LIST = "Cart-history-list";

  static const String REGISTRATION_URI = "/api/v1/auth/register";
  static const String LOGIN_URI = "/api/v1/auth/login";

  static const String USER_INFO_URI="/api/v1/customer/info";

  static const String USER_ACCOUNT = "User-account";
  static const String POPULAR_PRODUCT_TYPE_ID = "2";
  static const String RECOMMENDED_PRODUCT_TYPE_ID = "3";

  static const String LOGIN_URL = BASE_URL + "/backend/account/Customer_Login.php";
  static const String SIGN_UP_URL = BASE_URL + "/backend/account/Add_New_Customer.php";
  static const String GET_PRODUCTS_URL = BASE_URL + "/backend/product/Get_Products.php";
  static const String GET_RECOMMENDED_URL = BASE_URL + "/backend/product/Get_Products.php";
}
import 'package:zxvision1/models/cart_model.dart';
// total: (subTotal*(1+AppConstants.TAX)).toStringAsFixed(2),
// createdTime: 'Temp',
// paymentMethod: 'Temp',
// customerAddress: location.address,
// customerName: user!.name,
// customerPhone: user!.phone,
// orderId: 'Temp',
// orderStatus: 'Temp',
// tips: 'Temp',
// remarks: "Not about the food",
class PlaceOrderBody {
  // List<CartModel>? _cart;
  late String _products;
  late String _subTotal;
  late String _tax;
  late String _total;
  late String _createdTime;
  late String _paymentMethod;
  late String _customerAddress;
  late String _customerName;
  late String _customerPhone;
  late String _orderId;
  late String _orderStatus;
  late String _tips;
  late String _remarks;

  PlaceOrderBody(
      {
        // required List<CartModel> cart,
        required String products,
        required String subTotal,
        required String tax,
        required String total,
        required String createdTime,
        required String paymentMethod,
        required String customerAddress,
        required String customerName,
        required String customerPhone,
        required String orderId,
        required String orderStatus,
        required String tips,
        required String remarks,
      }){
    this._products = products;
    this._subTotal = subTotal;
    this._tax = tax;
    this._total = total;
    this._createdTime = createdTime;
    this._paymentMethod = paymentMethod;
    this._customerAddress = customerAddress;
    this._customerName = customerName;
    this._customerPhone = customerPhone;
    this._orderId = orderId;
    this._orderStatus = orderStatus;
    this._tips = tips;
    this._remarks = remarks;
  }

  String get cart => _products;
  String get subTotal => _subTotal;
  String get tax => _tax;
  String get total => _total;
  String get createdTime => _createdTime;
  String get paymentMethod => _paymentMethod;
  String get customerAddress => _customerAddress;
  String get customerPhone => _customerPhone;
  String get customerName => _customerName;
  String get orderId => _orderId;
  String get orderStatus => _orderStatus;
  String get tips => _tips;
  String get remarks => _remarks;

  PlaceOrderBody.fromJson(Map<String, dynamic> json) {
    // if (json['cart'] != null) {
    //   _cart = [];
    //   json['cart'].forEach((v) {
    //     _cart!.add(new CartModel.fromJson(v));
    //   });
    // }

    _products = json['products'];
    _subTotal = json['sub_total'];
    _tax = json['tax'];
    _total = json['total'];
    _createdTime = json['created_time'];
    _paymentMethod = json['payment_method'];
    _customerAddress = json['customer_address'];
    _customerName = json['customer_name'];
    _customerPhone = json['customer_phone'];
    _orderId = json['order_id'];
    _orderStatus = json['order_status'];
    _tips = json['tips'];
    _remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    // if (this._cart != null) {
    //   data['cart'] = this._cart!.map((v) => v.toJson()).toList();
    // }
    data['products'] = this._products;
    data['sub_total'] = this._subTotal;
    data['tax'] = this._tax;
    data['total'] = this._total;
    data['created_time'] = this._createdTime;
    data['payment_method'] = this._paymentMethod;
    data['customer_address'] = this._customerAddress;
    data['customer_name'] = this._customerName;
    data['customer_phone'] = this._customerPhone;
    data['order_id'] = this._orderId;
    data['order_status'] = this._orderStatus;
    data['tips'] = this._tips;
    data['remarks'] = this._remarks;
    return data;
  }

}
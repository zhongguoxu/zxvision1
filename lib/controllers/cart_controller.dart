import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zxvision1/data/repository/cart_repo.dart';
import 'package:zxvision1/models/products_model.dart';

import '../models/cart_model.dart';
import '../utils/colors.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items={};
  Map<int, CartModel> get items=>_items;
  List<CartModel> storageItems=[]; // only for storage and sharedpreference

  int _tipIndex = 0;
  int get tipIndex => _tipIndex;
  double _tipAmount = 3;
  double get tipAmount => _tipAmount;

  int _paymentIndex = 0;
  int get paymentIndex => _paymentIndex;
  String _deliveryType = "delivery";
  String get deliveryType => _deliveryType;
  String _orderNote = "";
  String get orderNote => _orderNote;

  void addItem(ProductModel product, int quantity) {
    var totalQuantity=0;
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity=value.quantity!+quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: quantity+value.quantity!,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });
      if (totalQuantity<=0) {
        _items.remove(product.id!);
      }
    } else {
      if (quantity>0) {
        _items.putIfAbsent(product.id!, () => CartModel(
          id: product.id,
          name: product.name,
          price: product.price,
          img: product.img,
          quantity: quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        ));
      } else {
        Get.snackbar("Item count", "You should at least add an item!",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      }
    }
    cartRepo.addToCartList(getItems);
    update();

  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id!)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity=0;
    if (_items.containsKey(product.id!)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity=0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  double get totalAmout {
    var total=0.0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList(); // setCart is to call the setCart function below where storageItems are updated
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    for(int i=0; i<storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items={};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
  }

  void clearCartHistory() {
    cartRepo.clearCartHistory();
    update();
  }

  void removeCartSharedPreference() {

  }

  String compressCartIntoString(List<CartModel> cartList) {
    var proStr = "";
    var kk = -1;
    for (var cart in cartList) {
      kk += 1;
      proStr += cart.product!.name!;
      proStr += ",";

      proStr += cart.price!.toString();
      proStr += ",";

      proStr += cart.quantity!.toString();
      proStr += ",";

      proStr += cart.img!;

      if (kk < (cartList.length - 1)) {
        proStr += ";";
      }
    }
    return proStr;
  }

  double calculateSubtotal(List<CartModel> cartList) {
    var subTotal = 0.0;
    for (var cart in cartList) {
      subTotal += cart.quantity! * cart.product!.price!;
    }
    return subTotal;
  }

  void setPaymentIndex(int index) {
    _paymentIndex = index;
    update();
  }

  void setDeliveryType(String type) {
    _deliveryType = type;
    update();
  }

  void setOrderNote(String note) {
    _orderNote = note;
    update();
  }

  void setTipIndex(int index) {
    _tipIndex = index;
    update();
  }

  void setTipAmount({int index=0, double customTip=-1}) {
    if (customTip >= 0) {
      _tipAmount = customTip;
    } else {
      if (index == 0) {
        _tipAmount = 3.0;
      }
      if (index == 1) {
        _tipAmount = 5.0;
      }
      if (index == 2) {
        _tipAmount = 10.0;
      }
    }
    print("zack new tip amount is "+_tipAmount.toString());
    update();
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:ojos_app/features/product/domin/entities/cart_entity.dart';
import 'dart:math' as math;

//To control the choice of answers
class CartProvider with ChangeNotifier {
  CartProvider() {
    initList();
  }

  List<CartEntity> listOfCart = [];

  get getListOfItems => listOfCart;

  addItemToCart(CartEntity cartEntity) {
    print('item new is ${cartEntity.id}');
    print('isExist(cartEntity) ${cartEntity.id} ${isExist(cartEntity)}');
    if (isExist(cartEntity)) {
      /* if (cartEntity.argsForGlasses != null) {
        print('updateee');
        updateArgs(cartEntity);
      }*/
      increaseItemCount(cartEntity.id);
    } else {
      listOfCart.add(cartEntity);
    }

    notifyListeners();
  }

  bool isExist(CartEntity cartEntity) {
    if (listOfCart.isNotEmpty) {
      for (CartEntity item in listOfCart) {
        if (item.id == cartEntity.id) {
          return true;
        }
      }
      return false;
    } else {
      return false;
    }
  }

  updateArgs(CartEntity cartEntity) {
    print('updateee');
    if (listOfCart.isNotEmpty) {
      for (CartEntity item in listOfCart) {
        if (item.id == cartEntity.id) {
          print('updateee');
          // item.argsForGlasses = cartEntity.argsForGlasses;
        }
      }
    }
  }

  initList() async {
    //   listAnswer = new Map();
    listOfCart = [];
  }

  clearList() {
    // listAnswer = new Map();
    listOfCart.clear();
    notifyListeners();
  }

  setItemCount() {}

/*  getTotalPrices() {
    double total = 0;
    if (listOfCart.isNotEmpty) {
      for (CartEntity item in listOfCart) {
        if ((item.productEntity.priceAfterDiscount.isNotEmpty) ||
            item.productEntity.priceAfterDiscount != '0') {
          total +=
              (double.parse(item.productEntity.priceAfterDiscount ?? '0.0') *
                  (item.count ?? 1));
        } else {
          total += (item.productEntity.price ?? 1.0) * (item.count ?? 1);
        }
      }
    }
    return total;
  }*/
  getTotalPricesAfterDiscount() {
    double total = 0;
    if (listOfCart.isNotEmpty) {
      for (CartEntity item in listOfCart) {
        if ((item.productEntity!.discountPrice != null) ||
            item.productEntity!.discountPrice != '0') {
          total += ((item.productEntity!.discountPrice ?? 0.0) -
                      (item.productEntity!.price!))
                  .abs() *
              (item.count!);
        } else {
          total += (item.productEntity!.price!) * (item.count!);
        }
      }
    }
    return total;
  }

  getTotalPricesint() {
    double total = 0;
    if (listOfCart.isNotEmpty) {
      for (CartEntity item in listOfCart) {
        if (item.productEntity!.price == null) {
          item.productEntity!.price = 0.0;
          total += (item.productEntity!.price!).abs() * (item.count!);
        } else {
          total += (item.productEntity!.price!) * (item.count!);
        }
      }
    }
    return total.toInt();
  }

  increaseItemCount(int? id) {
    if (listOfCart.isNotEmpty) {
      for (CartEntity item in listOfCart) {
        if (item.id != null && item.id == id) {
          item.count = (item.count!) + 1;
        }
      }
    }
    notifyListeners();
  }

  decreaseItemCount(int? id) {
    if (listOfCart.isNotEmpty) {
      for (CartEntity item in listOfCart) {
        if (item.id != null && item.id == id) {
          if (item.count == 1) {
            listOfCart.removeWhere((element) => element.id == id);
            notifyListeners();
          } else
            item.count = (item.count!) - 1;
        }
      }
    }
    notifyListeners();
  }

  List<dynamic>? getItems() {
    return listOfCart;
  }

  int getItemsCount() {
    int count = 0;
    if (listOfCart.isNotEmpty) {
      for (CartEntity item in listOfCart) {
        if (item.count != null && item.count != 0) {
          count += (item.count!);
        }
      }
    }
    return count;
  }
}

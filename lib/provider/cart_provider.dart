import 'package:flutter/material.dart';
import 'package:muslimahbakery/models/cart_model.dart';
import 'package:muslimahbakery/models/product_model.dart';




class CartProvider extends ChangeNotifier {
  final List<CartModel> _shoppingCart = [];

  void addToCart(ProductModel product) {
    var isExist = _shoppingCart.where((element) => element.product.id == product.id);
    if (isExist.isEmpty) {
      _shoppingCart.add(CartModel(
        product: product,
        quantity: 1,
      ));
    } else {
      isExist.first.quantity += 1;
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _shoppingCart.removeWhere((element) => element.id == productId);
    notifyListeners();
  }

  void incrementQty(String productId) {
    CartModel item =
        _shoppingCart.where((element) => element.id == productId).first;
    item.quantity++;
    notifyListeners();
  }

  void decrimentQty(String productId) {
    CartModel item =
        _shoppingCart.where((element) => element.id == productId).first;

    if (item.quantity > 1) {
      item.quantity--;
    } else {
      _shoppingCart.remove(item);
    }
    notifyListeners();
  }

  double getCartTotal() {
    double total = 0;
    for(var cartItem in _shoppingCart) {
      total += (cartItem.product.price * cartItem.quantity);
    }
    return total;
  }

  List<CartModel> get shoppingCart => _shoppingCart;
  double get cartSubTotal => getCartTotal();
  double get cartTotal => cartSubTotal;

  void clearCart() {}
}
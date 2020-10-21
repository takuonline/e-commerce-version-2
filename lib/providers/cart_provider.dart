import 'package:flutter/material.dart';
import 'package:takuonline/cart/trolley.dart';

class CartList with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  void addToCart(Product value) {
    _items.add(value);
    notifyListeners();
  }

  void removeFromCart(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clearCart(){
    _items.clear();
    notifyListeners();
  }
}

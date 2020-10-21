import 'package:flutter/material.dart';
import 'package:takuonline/cart/trolley.dart';

class WishList with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  void addToWishList(Product value) {
    _items.add(value);
    notifyListeners();
  }
}

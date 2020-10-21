import 'package:flutter/material.dart';
import 'package:takuonline/cart/trolley.dart';

class ProductList with ChangeNotifier {
  List<Product> _items = [
    Product(
      'product 1',
      AssetImage('images/sneakers.png'),
      'Sneakers',
      1200,
      1500,
      true,
      1,
      false,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
          ' Nunc ultricies sapien molestie lacus elementum iaculis. Mauris'
          ' et eros non lacus efficitur ullamcorper.  ',
    ),
    Product(
      'product 2',
      AssetImage('images/shoes2.jfif'),
      'Kitten heel',
      3000,
      3000,
      false,
      1,
      false,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
          ' Nunc ultricies sapien molestie lacus elementum iaculis. Mauris'
          ' et eros non lacus efficitur ullamcorper.  ',
    ),
    Product(
      'product 3',
      AssetImage('images/shoes3.jfif'),
      'Black Shoes',
      1200,
      1400,
      false,
      1,
      false,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
          ' Nunc ultricies sapien molestie lacus elementum iaculis. Mauris'
          ' et eros non lacus efficitur ullamcorper.  ',
    ),
    Product(
      'product 4',
      AssetImage('images/shoes5.jfif'),
      'White Shoe',
      1200,
      1500,
      false,
      1,
      false,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
          ' Nunc ultricies sapien molestie lacus elementum iaculis. Mauris'
          ' et eros non lacus efficitur ullamcorper.  ',
    ),
    Product(
      'product 5',
      AssetImage('images/shoes.png'),
      'Spectator shoe',
      1200,
      1200,
      false,
      1,
      false,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
          ' Nunc ultricies sapien molestie lacus elementum iaculis. Mauris'
          ' et eros non lacus efficitur ullamcorper.  ',
    ),
    Product(
      'product 6',
      AssetImage('images/shoes6.jfif'),
      'Sneakers_2',
      200,
      370,
      true,
      1,
      false,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
          ' Nunc ultricies sapien molestie lacus elementum iaculis. Mauris'
          ' et eros non lacus efficitur ullamcorper.  ',
    ),
    Product(
      'product 7',
      AssetImage('images/shoes.png'),
      'Wedge',
      1200,
      1550,
      false,
      1,
      false,
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
          ' Nunc ultricies sapien molestie lacus elementum iaculis. Mauris'
          ' et eros non lacus efficitur ullamcorper.  ',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }
//  void addProduct(Product value) {
//    _items.add(value);
//    notifyListeners();
//  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


final oCcy = new NumberFormat("#,##0.00", "en_US");

class Product with ChangeNotifier{
  String cartID;
  AssetImage productImage;
  String productName;
  int price;
  int discountedPrice;
  bool isSale;
  int quantity;
  bool isFav;
  String productDetails;


  Product(
      [
      this.cartID ,
      this.productImage,
      this.productName,
      this.price,
      this.discountedPrice,
      this.isSale = false,
      this.quantity= 1,
      this.isFav=false,
        this.productDetails
      ]);

  void toggleFav(){
    isFav = !isFav;
    notifyListeners();
  }
}


//List itemTrolley = [];
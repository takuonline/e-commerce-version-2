import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:takuonline/pages/item_page.dart';
import 'package:takuonline/components/constants.dart';
import 'package:takuonline/providers/is_signed_in.dart';

import 'package:takuonline/providers/wishlist_provider.dart';
import 'package:takuonline/cart/trolley.dart';
import 'package:provider/provider.dart';
import 'package:takuonline/widgets/register_dialog.dart';

class MenuCard extends StatefulWidget {
  @override
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final _product = context.watch<Product>();

    return GestureDetector(
      onTap: () {
        print("item clicked");
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ItemPage(_product);
          },
        ));
      },
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: screenWidth * .015, vertical: 0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(screenWidth * .05),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black.withOpacity(.12),
                  blurRadius: 10.0,
                  offset: Offset(0.0, 0.0),
                  spreadRadius: 2)
            ],
            border: Border.all(color: Colors.white.withOpacity(.4), width: 5)),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                      image: DecorationImage(
                          image: _product.productImage, fit: BoxFit.cover),
                    ),
                  ),
                  if (_product.discountedPrice != _product.price)
                    Transform.translate(
                      offset: Offset(0, 25),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Material(
                          color: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(100),
                                  topLeft: Radius.circular(100))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 4),
                            child: Text(
                              "${((_product.price - _product.discountedPrice) * 100 ~/ _product.price)}%",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _product.productName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis ,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'R ${oCcy.format(_product.price)}',
                          style: TextStyle(color: kGreyMedium, fontSize: 15),
                        ),
                        addToWishList(context, _product.cartID, _product),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector addToWishList(BuildContext context, String id, _product) {
//    var data =  context.watch<Product>();

    return GestureDetector(
      onTap: () {
        print('add to fav button');


        if (context.read<IsLoggedIn>().isLoggedIn){
          _product.toggleFav();
          context.read<WishList>().addToWishList(
            Product(
              id,
              _product.productImage,
              _product.productName,
              _product.price,
              _product.discountedPrice,
              _product.isSale,
            ),
          );
          }
        else {
          RegisterDialog.registerDialog(context);
        }

      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
        child: Icon(
          _product.isFav ? Icons.favorite : Icons.favorite_border,
          color: _product.isFav ? Colors.red: kGreyMedium,
        ),
      ),
    );
  }
}

//Container myCard = Container(
//  width: 70,
//  height: 80,
//  decoration: BoxDecoration(
//   borderRadius: BorderRadius.circular(20)
//  ),
//  child: Column(
//    children: [
//      Stack(
//        children: [
//          Container(
//            width: 70,
//            height: 80,
//            decoration: BoxDecoration(
//              image: DecorationImage(
//                image:
//                _product.productImage,
//              ),
//
//            ),
//          ),
//
//          Material(
//            color: kPrimaryColor,
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100),topLeft: Radius.circular(100))
//            ),
//            child: Text(
//              "-20%"
//            ),
//          )
//        ],
//      ),
//
//      Text(
//        _product.productName,style:  Theme.of(context).textTheme.headline6,
//      ),
//      Text(
//        _product.productName,style:  Theme.of(context).textTheme.headline6,
//      ),
//
//    ],
//  ),
//
//
//
//
//)

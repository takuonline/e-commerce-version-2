import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:takuonline/cart/trolley.dart';
import 'package:takuonline/components/constants.dart';
import 'package:takuonline/components/named_bottom_nav.dart';
import 'package:takuonline/pages/cart.dart';
import 'package:takuonline/pages/item_page.dart';
import 'package:takuonline/pages/menu_page.dart';
import 'package:takuonline/providers/bottom_nav_index_provider.dart';
import 'package:takuonline/providers/cart_provider.dart';
import 'package:takuonline/providers/product_provider.dart';
import 'package:provider/provider.dart';

class WishListPage extends StatefulWidget {
  static String id = 'WishList';
  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  Widget build(BuildContext context) {
    List<Product> _wishList = context
        .watch<ProductList>()
        .items
        .where((element) => element.isFav == true)
        .toList();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    List<Product> _cartList = context.watch<CartList>().items;

    bool onWillPop() {
      Navigator.pushReplacementNamed(context, MenuPage.id);
      BottomNavIndex bottomNavIndex =
          Provider.of<BottomNavIndex>(context, listen: false);
      bottomNavIndex.setBottomNavIndex(0);
      return false;
    }

    return WillPopScope(
      onWillPop: () => Future.sync(onWillPop),
      child: SafeArea(
        child: Scaffold(
          body: Container(
            margin: EdgeInsets.only(bottom: 60),
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Wish List',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Cart.id);
                        },
                        child: Stack(
                          children: <Widget>[
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.black,
                              size: 25,
                            ),
                            Transform.translate(
                              offset: Offset(10, -5),
                              child: Material(
                                color: kPrimaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: Text(
                                    '${_cartList.length}',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      controller: ScrollController(),
                      itemCount: _wishList.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        color: Colors.black.withOpacity(
                          .2,
                        ),
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ItemPage(
                                        _wishList[index]
                                    );
                                  },
                                )
                            );
                          },
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: Image.asset(
                                        _wishList[index].productImage.assetName,
                                        fit: BoxFit.cover,
                                        height: screenHeight * .27,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              _wishList[index].productName,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "R${_wishList[index].price}  ",
                                              style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(
                                    _wishList[index].productDetails,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.black87,
                                        letterSpacing: 1.0,
                                        height: 1.4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottomSheet: CustomBottomNav(),
        ),
      ),
    );
  }
}

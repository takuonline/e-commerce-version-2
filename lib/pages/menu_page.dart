import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:takuonline/components/named_bottom_nav.dart';
import 'package:takuonline/pages/cart.dart';
import 'package:takuonline/components/constants.dart';
import 'package:takuonline/components/app_drawer.dart';
import 'package:takuonline/components/menu_card.dart';
import 'package:takuonline/cart/trolley.dart';
import 'package:provider/provider.dart';
import 'package:takuonline/providers/cart_provider.dart';
import 'package:takuonline/providers/product_provider.dart';
import 'package:takuonline/widgets/category_card.dart';

class MenuPage extends StatefulWidget {
  static const id = 'MenuPage';

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget buildAnimatedItem(BuildContext context, int index,
          Animation<double> animation, List<Product> _productList) =>
      // For example wrap with fade transition
      FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        // And slide transition
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          // Paste you Widget
          child: ChangeNotifierProvider.value(
            value: _productList[index],
            child: MenuCard(),
          ),
        ),
      );

  final options = LiveOptions(
      delay: Duration(milliseconds: 300),
      showItemInterval: Duration(milliseconds: 300),
      showItemDuration: Duration(milliseconds: 200),
      visibleFraction: 0.05,

      reAnimateOnVisibility: false);


  @override
  Widget build(BuildContext context) {
    List<Product> _productList = context.watch<ProductList>().items;
    List<Product> _cartList = context.watch<CartList>().items;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(

          appBar: PreferredSize(
            preferredSize: Size(screenWidth, screenHeight * .11),
            child: Container(
              decoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(.12),
//                  gradient: LinearGradient(
//                colors: [Colors.white, Color(0xffffffff)],
//                begin: FractionalOffset(0.0, 0.0),
//                end: FractionalOffset(0.0, 1),
//              ),
              
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Menu',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 30),
                      ),
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .11,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Cart.id);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 10),
                      child: Stack(
                        children: <Widget>[
                          Icon(Icons.shopping_cart, color: Colors.black),
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
            ),
          ),
          drawer: AppDrawer(),
          body: ListView(
            shrinkWrap: true,
            controller: ScrollController(),
            children: [
              Container(
                color: kPrimaryColor.withOpacity(.12),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                      child: Text(
                        "Categories",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth,
                      height: screenHeight * .2,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          CategoryCard(
                               image: 'images/shoe-category2.jpg',name: 'Category A'),
                          CategoryCard(
                               image: 'images/shoe-category3.jpg',name: 'Category B'),
                          CategoryCard(
                               image: 'images/shoe-category4.jpg',name: 'Category C'),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                      child: Text(
                        "Trending",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    LiveGrid.options(
//                        controller: ScrollController(),
                      physics:NeverScrollableScrollPhysics(),
                      options: options,
                      shrinkWrap: true,
                      // Like GridView.builder, but also includes animation property
                      itemBuilder: (
                        contx,
                        index,
                        animation,
                      ) =>
                          buildAnimatedItem(
                              contx, index, animation, _productList),
                      // Other properties correspond to the `ListView.builder` / `ListView.separated` widget
                      itemCount: _productList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 25,
                        childAspectRatio:  1/1.1,


                      ),
                    ),

                  ],
                ),
              ),


            ],
          ),
          bottomNavigationBar: CustomBottomNav()),
    );
  }
}



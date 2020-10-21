import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takuonline/components/constants.dart';
import 'package:takuonline/pages/cart.dart';
import 'package:takuonline/pages/register_page.dart';
import 'package:takuonline/providers/is_signed_in.dart';
import 'package:takuonline/widgets/register_dialog.dart';

import 'package:uuid/uuid.dart';
import 'package:takuonline/cart/trolley.dart';

import 'package:provider/provider.dart';
import 'package:takuonline/providers/cart_provider.dart';

class ItemPage extends StatefulWidget {
  static const id = 'ItemPage';

  Product product;

  ItemPage([this.product]);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> with TickerProviderStateMixin {
  int itemCount = 0;
  int itemPrice = 1200;
  bool displayDialog = false;

  AssetImage cardImage;
  String cardName;
  int price;
  int discountedPrice;
  bool isSale;
  String cartID;
  int quantity;
  bool isFav;

  AnimationController _controller;

  Animation<double> fadeAnimation;
  Animation<double> fadeAnimation2;
  Animation<double> fadeAnimation3;
  Animation<double> fadeAnimation4;

  Animation<Offset> slideAnimation;
  Animation<Offset> slideAnimation2;
  Animation<Offset> slideAnimation3;
  Animation<Offset> slideAnimation4;

  double _iconSize = 25;

  bool isSecondImageVisible = false;
  double secondImageOpacity = 1;
  double secondImageHeight = 20;
  double secondImageWidth = 20;

  var uuid = Uuid();

  Future<void> productdialog() async {
    showDialog(
        context: context,
        builder: await (ctx) => AlertDialog(
              backgroundColor: kPrimaryColor,
              title: Text('Buy this item?'),
              content: Text('Do you want to add this item to your cart'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    var uuid = Uuid();
                    String cartProductId = uuid.v1();

                    context.read<CartList>().addToCart(
                          Product(cartProductId, cardImage, cardName, price,
                              discountedPrice, isSale, quantity),
                        );
                    Navigator.of(context).pop();
                    setState(() {
                      isSecondImageVisible = true;
                      secondImageOpacity = 0;
                    });
                  },
                  child: Text('Yes'),
                )
              ],
            ));
  }



  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    _controller.forward();

    slideAnimation = Tween<Offset>(
      begin: Offset(0, .15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0, .7, curve: Curves.ease),
    ));

    _controller.addListener(() => setState(() {}));
  }

  double setSecondImageOpacity() {
    if (isSecondImageVisible) {
      return 0;
    } else {
      return 1;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> _cartList = context.watch<CartList>().items;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    cardImage = widget.product.productImage;
    cardName = widget.product.productName;
    price = widget.product.price;
    discountedPrice = widget.product.discountedPrice;
    isSale = widget.product.isSale;
    cartID = widget.product.cartID;
    quantity = widget.product.quantity;

    Image secondImage = Image(
      image: cardImage,
      fit: isSecondImageVisible ? BoxFit.contain : BoxFit.cover,
      width: isSecondImageVisible ? screenWidth : 20,
      height: isSecondImageVisible ? screenHeight * .5 : 20,
    );

//    void secondImageAnimation() {
//      setState(() {
//        isSecondImageVisible = true;
//      });
//    }

    final _auth = FirebaseAuth.instance;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Stack(
              children: [
                Image(
                  image: cardImage,
                  fit: BoxFit.cover,
                  width: screenWidth,
                  height: screenHeight * .5,
                ),
                AnimatedPositioned(
                    duration: Duration(seconds: 1),
                    curve: Curves.ease,
                    top: isSecondImageVisible ? 17 : 0,
                    width: isSecondImageVisible ? 20 : screenWidth,
                    height: isSecondImageVisible ? 20 : screenHeight * .5,
                    right: isSecondImageVisible ? 20 : 0,
                    onEnd: () {
                      setState(() {
                        isSecondImageVisible = false;
                        secondImageOpacity = 0;
                      });
                    },
                    child: AnimatedOpacity(
                        opacity: secondImageOpacity,
                        duration: Duration(seconds: 1),
                        child: AnimatedSize(
                            duration: Duration(seconds: 1),
                            vsync: this,
                            curve: Curves.ease,
                            child: secondImage))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, Cart.id);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        child: Stack(
                          children: <Widget>[
                            AnimatedContainer(
                              duration: Duration(seconds: 1),
                              child: Icon(
                                Icons.shopping_cart,
                                color: Colors.black,
                                size: _iconSize,
                              ),
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
              ],
            ),
            SlideTransition(
              position: slideAnimation,
              child: DraggableScrollableSheet(
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    padding: EdgeInsets.only(top: 0),
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(45),
                        )),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  cardName,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "R$price a pair",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                      ),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            IconButton(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              onPressed: () {
                                                setState(() {
                                                  widget.product.quantity++;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                color: kGreyMedium,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              child: Text(
                                                '$quantity',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20.0,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    if (widget
                                                            .product.quantity <=
                                                        1) {
                                                      print(
                                                          'item count is at one');
                                                    } else {
                                                      widget.product.quantity--;
                                                    }
                                                  });
                                                },
                                                icon: Icon(Icons.remove,
                                                    color: kGreyMedium),
                                              ),
                                            ),
                                          ]),
                                    ),
                                    Text(
                                      "R${oCcy.format(price * quantity)}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "Details",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  widget.product.productDetails,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 10,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black87,
                                      letterSpacing: 1.0,
                                      height: 1.2),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      widget.product.isFav =
                                          !widget.product.isFav;
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 30),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        widget.product.isFav
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color:  widget.product.isFav? Colors.red :kGreyMedium,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (context.read<IsLoggedIn>().isLoggedIn) {
                                    productdialog();
                                  } else {
                                    RegisterDialog.registerDialog(context);
                                  }
                                },
                                child: Container(
                                  width: screenWidth * .5,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(200),
                                          bottomLeft: Radius.circular(200))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Add to cart",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6),
                                        Icon(
                                          Icons.add_shopping_cart,
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

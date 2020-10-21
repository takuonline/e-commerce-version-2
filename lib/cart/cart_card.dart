import 'package:flutter/material.dart';
import 'package:takuonline/cart/trolley.dart';
import 'package:takuonline/components/constants.dart';
import 'package:takuonline/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartCard extends StatefulWidget {
  int cartPrice;
  String cartName;
  AssetImage cartImage;
  int discountedPrice;
  bool isSale;
  String cartID;
  int quantity;
  int index;
  Function updateState;
  CartCard(
      {this.cartPrice,
      this.cartName,
      this.cartImage,
      this.discountedPrice,
      this.isSale,
      this.cartID,
      this.quantity,
      this.index,
      this.context,
      this.updateState});

  BuildContext context;

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  GestureDetector additionButton(String cartID, List<Product> _trolleyList) {
    return GestureDetector(
      onTap: () {

        setState(() {
          widget.updateState();
          for (var item in _trolleyList) {
            if (item.cartID == cartID) {
              item.quantity++;
            }
          }
        });
      },
      child: Container(
          padding:
              EdgeInsets.all(MediaQuery.of(widget.context).size.width * .01),
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(
            Icons.add,
            color: Colors.black,
          )),
    );
  }

  GestureDetector subtractionButton(
      String cartID, List<Product> _trolleyList, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.updateState();
          for (var item in _trolleyList) {
            if (item.cartID == cartID) {
              if (item.quantity == 1) {
                showCartDialog(index);
              }

              if (item.quantity > 1) {
                item.quantity--;
              }
            }
          }
        });
      },
      child: Container(
          padding:
              EdgeInsets.all(MediaQuery.of(widget.context).size.width * .01),
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(
            Icons.remove,
            color: Colors.black,
          )),
    );
  }

  GestureDetector closingButton(
    int index,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        context.read<CartList>().removeFromCart(index);
      },
      child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * .01),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Icon(
            Icons.close,
            color: Colors.black,
          )),
    );
  }

  Future<void> showCartDialog(int index) async {
    showDialog(
        context: widget.context,
        builder: await (ctx) => AlertDialog(
              backgroundColor: kSecondaryColor,
              title: Text('Remove item from cart'),
              content: Text('Do you want to remove this item from your cart'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    widget.context.read<CartList>().removeFromCart(index);
                    Navigator.of(widget.context).pop();
                  },
                  child: Text('Yes'),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(widget.context).pop();
                  },
                  child: Text('No'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    List<Product> _trolleyList = context.watch<CartList>().items;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Dismissible(
      key: Key(widget.cartID),
      onDismissed: (direction) {
        context.read<CartList>().removeFromCart(widget.index);
      },
      secondaryBackground: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
      background: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.fromLTRB(30, 40, 30, 0),
        height: 130.0,
        width: screenWidth * .8,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Image(
                  width: 120,
                  image: widget.cartImage,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.cartName,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: MediaQuery.of(context).size.width * .057,
                        ),
                      ),
                      Flexible(
                        child: SizedBox(
                          height: 10,
                        ),
                      ),
                      Text(
                        'R ${oCcy.format(widget.cartPrice)}',
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 20.0,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          additionButton(widget.cartID, _trolleyList),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              '${_trolleyList[widget.index].quantity}',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0),
                            ),
                          ),
                          subtractionButton(
                              widget.cartID, _trolleyList, widget.index),
                          SizedBox(width: 5.0),
                          closingButton(
                            widget.index,
                            context,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

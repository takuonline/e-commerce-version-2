import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:takuonline/cart/cart_card.dart';
import 'package:takuonline/components/constants.dart';
import 'package:takuonline/providers/cart_provider.dart';

import 'package:takuonline/cart/trolley.dart';

import 'package:square_in_app_payments/models.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:takuonline/providers/is_signed_in.dart';
import 'package:takuonline/widgets/register_dialog.dart';

class Cart extends StatefulWidget {
  static const id = 'Cart';

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> with TickerProviderStateMixin {
  AnimationController _controller;
  int _total = 0;

  Animation imageAnimation;
  Animation<Offset> btnSlideAnimation;
  var minusBtnColor = kSecondaryColor;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    _controller.forward();

    imageAnimation = CurvedAnimation(
        parent: _controller,
        curve: Interval(0.1, .3, curve: Curves.easeOutBack));

    btnSlideAnimation = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(.3, .5, curve: Curves.easeOut),
    ));

    _controller.addListener(() {
      setState(() {});
    });
  }

  int getTotal(List itemTrolley) {

    for (var x in itemTrolley) {
      _total += x.quantity * x.price;
    }
    return _total;
  }
  void clearCart(){
    context.watch<CartList>().clearCart();
  }


  @override
  Widget build(BuildContext context) {
    List<Product> _trolley = context.watch<CartList>().items;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    void updateState(){
      setState(() {
        _total =getTotal(_trolley);
      });
    }

    void _checkIfCartIsReady(){





      if(_trolley.isEmpty){

        print('cart is empty');


      }else{

        if (context.read<IsLoggedIn>().isLoggedIn) {
          _initSquarePayment();
        } else {
          RegisterDialog.registerDialog(context);
        }
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Cart',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30.0,
                color: Colors.black),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              0, 0, 0, MediaQuery.of(context).size.height * .272),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Transform.scale(
                scale: imageAnimation.value,
                child: CartCard(
                    cartPrice: _trolley[index].price,
                    cartName: _trolley[index].productName,
                    cartImage: _trolley[index].productImage,
                    discountedPrice: _trolley[index].discountedPrice,
                    isSale: _trolley[index].isSale,
                    cartID: _trolley[index].cartID,
                    quantity: _trolley[index].quantity,
                    index: index,
                    context: context,
                updateState: updateState,
                ),
              );
            },
            itemCount: _trolley.length,
          ),
        ),
        bottomSheet: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            color: kGreyLight,
          ),
          height: MediaQuery.of(context).size.height * .27,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Quantity:', style: kBottomSheetText1),
                        Text(
                          '${_trolley.length}',
                          style: kBottomSheetText1,
                        )
                      ],
                    ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: [
//                        Text('Discount:', style: kBottomSheetText1),
//                        Text(
//                          'R300',
//                          style: kBottomSheetText1,
//                        ),
//                      ],
//                    ),
                    Divider(
                      color: kGreyMedium,

                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('SubTotal', style: kBottomSheetText2),
                        Text(
                          'R ${oCcy.format(_trolley.fold(0, (previous, current) => previous + current.quantity*current.price)) ?? 0}',
                          style: kBottomSheetText1,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SlideTransition(
                position: btnSlideAnimation,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap:
                        ()=>_checkIfCartIsReady()
                   ,
                   child : Container(
                      width: screenWidth * .5,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(200),
                              bottomLeft: Radius.circular(200))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Checkout",
                                style: Theme.of(context).textTheme.headline6),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.grey,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _initSquarePayment() async {
    await InAppPayments.setSquareApplicationId('sandbox-sq0idb-JEcnUULefBlYuoSlXqs4mQ');

    await InAppPayments.startCardEntryFlow(
        onCardNonceRequestSuccess: _onCardEntryCardNonceRequestSuccess,
        onCardEntryCancel: _onCancelCardEntryFlow);
  }

  void _onCardEntryCardNonceRequestSuccess (CardDetails result) async {
    try {
      // take payment with the card nonce details
      // you can take a charge
      // await chargeCard(result);

      // payment finished successfully
      // you must call this method to close card entry
       result.nonce;
       print(result.card);
       print(result.nonce);

      InAppPayments.completeCardEntry(

          onCardEntryComplete: _onCardEntryComplete);
    } on Exception catch (ex) {
      // payment failed to complete due to error
      // notify card entry to show processing error
      InAppPayments.showCardNonceProcessingError(ex.toString());
    }
  }

  void _onCardEntryComplete() {
    print("Is done");
    clearCart();
    // Update UI to notify user that the payment flow is finished successfully
  }

  void _onCancelCardEntryFlow() {
    print("request has been canceled");
    // Handle the cancel callback
  }


}

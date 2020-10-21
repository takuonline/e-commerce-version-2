import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takuonline/cart/trolley.dart';
import 'package:takuonline/components/shoe_search.dart';
import 'package:takuonline/pages/cart.dart';
import 'package:takuonline/components/constants.dart';
import 'package:takuonline/pages/item_page.dart';
import 'package:takuonline/pages/menu_page.dart';
import 'package:takuonline/pages/wishlist.dart';
import 'package:takuonline/providers/bottom_nav_index_provider.dart';
import 'package:takuonline/providers/is_signed_in.dart';
import 'package:takuonline/providers/product_provider.dart';
import 'package:takuonline/widgets/register_dialog.dart';



class CustomBottomNav extends StatelessWidget {
  void _onNavBarItemTapped(int index, BuildContext context) {
//    int _selectedNavItem = Provider.of<BottomNavIndex>(context, listen: false).bottomNavIndex;

    BottomNavIndex providerData = Provider.of<BottomNavIndex>(context, listen: false);

    if (index == 0) {
      providerData.setBottomNavIndex(index);
      if (ModalRoute.of(context).settings.name != 'MenuPage') {
        Navigator.pushReplacementNamed(context, MenuPage.id);
        Provider.of<BottomNavIndex>(context, listen: false)
            .setBottomNavIndex(0);
      }
    } else if (index == 1) {

      if (context.read<IsLoggedIn>().isLoggedIn){
        providerData.setBottomNavIndex(index);

        if (ModalRoute.of(context).settings.name != 'WishList') {
          Navigator.pushReplacementNamed(context, WishListPage.id);
          Provider.of<BottomNavIndex>(context, listen: false)
              .setBottomNavIndex(1);
        }
      } else {
        RegisterDialog.registerDialog(context);
      }




    } else if (index == 2) {

      if (ModalRoute.of(context).settings.name == 'WishList') {

        Provider.of<BottomNavIndex>(context, listen: false).setBottomNavIndex(1);

      }


      showSearchResults(context);


    } else if (index == 3) {
      providerData.setBottomNavIndex(index);
      if (ModalRoute.of(context).settings.name != 'Cart') {
        Navigator.pushReplacementNamed(context, Cart.id);
        Provider.of<BottomNavIndex>(context, listen: false)
            .setBottomNavIndex(3);
      }
    }
  }

  showSearchResults(BuildContext context) async {
    final result = await showSearch(context: context, delegate: ShoeSearch());

    if (result != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ItemPage(result);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    int _selectedNavItem = Provider.of<BottomNavIndex>(context).bottomNavIndex;

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      child: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        unselectedItemColor: kGreyMedium,
        onTap: (index) {
          _onNavBarItemTapped(index, context);
        },
        currentIndex: _selectedNavItem,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label:  'Home' ,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'WishList' ,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label:  'Search' ,
          ),
        ],
      ),
    );
  }
}

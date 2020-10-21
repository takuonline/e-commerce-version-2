import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:takuonline/components/constants.dart';
import 'package:takuonline/pages/login_page.dart';
import 'package:takuonline/pages/register_page.dart';
import 'package:takuonline/pages/wishlist.dart';
import 'package:takuonline/providers/bottom_nav_index_provider.dart';
import 'package:takuonline/providers/cart_provider.dart';
import 'package:takuonline/providers/is_signed_in.dart';
import 'package:takuonline/providers/product_provider.dart';
import 'package:takuonline/providers/wishlist_provider.dart';
import 'pages/welcome_page.dart';
import 'pages/menu_page.dart';
import 'pages/cart.dart';
import 'pages/item_page.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartList(),
        ),
        ChangeNotifierProvider(
          create: (_) => WishList(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => BottomNavIndex(),
        ),
        ChangeNotifierProvider.value(
         value: IsLoggedIn(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
            primaryColor: kPrimaryColor,
            appBarTheme: AppBarTheme(color: Colors.white),
            bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: Colors.black.withOpacity(0)),
            scaffoldBackgroundColor:Colors.white,
            textTheme: TextTheme(
              headline1: TextStyle(
                  color: Colors.black,
                  fontSize: 75,
                  letterSpacing: 5,
                  fontWeight: FontWeight.w900,
                  height: 1),
              headline2: TextStyle(
                  color: Colors.black,
                  fontSize: 75,
                  letterSpacing: 5,
                  fontWeight: FontWeight.w200,
                  height: 1),
              headline6: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              headline5: TextStyle(
                color:  kGreyMedium,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              headline4: TextStyle(
                  color: Colors.black,
                  fontSize: 35,

                  fontWeight: FontWeight.w400,
                  height: 1),

            )

//textTheme: TextTheme(
// bodyText1: TextStyle(
//   fontSize: 1.0
// )
//),

//pageTransitionsTheme:  PageTransitionsTheme(
//  builders: ZoomPageTransitionsBuilder
//)
//        typography: Typography(
//          black:
//        )
            ),
        initialRoute: WelcomePage.id,
        routes: {
          WelcomePage.id: (context) => WelcomePage(),
          MenuPage.id: (context) => MenuPage(),
          Cart.id: (context) => Cart(),
          ItemPage.id: (context) => ItemPage(),
          WishListPage.id: (context) => WishListPage(),
          RegistrationPage.id: (context) => RegistrationPage(),
          Login.id: (context) => Login(),
//          SearchPage.id: (context) => SearchPage(),
        },
      ),
    );
  }
}

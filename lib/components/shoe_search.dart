import 'package:flutter/material.dart';
import 'package:takuonline/cart/trolley.dart';
import 'package:takuonline/pages/menu_page.dart';
import 'package:takuonline/providers/product_provider.dart';
import 'package:provider/provider.dart';


class ShoeSearch extends SearchDelegate {
  @override
  TextStyle get searchFieldStyle => TextStyle(
    color: Colors.black,
  );
  @override
  TextInputAction get textInputAction => TextInputAction.unspecified;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.orange,
      textTheme: TextTheme(headline6: TextStyle(color: Colors.black)),
      appBarTheme: AppBarTheme(elevation: 0, shadowColor: Colors.transparent),
    );


  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pushReplacementNamed(context, MenuPage.id);
        },
      ),
    );
  }

  @override
  Widget buildResults(
      BuildContext context,
      ) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var _providerData = Provider.of<ProductList>(context);
    final results = _providerData.items
        .where(
          (product) => product.productName.toLowerCase().contains(
        query.toLowerCase(),
      ),
    )
        .toList();

    return (query == '')
        ? Container()
        : ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            results[index].productName,
            style: TextStyle(color: Colors.black87),
          ),
          leading: Image.asset(
            results[index].productImage.assetName,
            width: 150,
          ),
          onTap: () {
            Product _product = results[index];
            print(_product.productName);
            close(context, results[index]);
          },
          focusColor: Colors.red,
        ));
  }
}
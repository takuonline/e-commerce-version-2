import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({Key key, this.image, this.name}) : super(key: key);

  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Container(
            width: screenWidth * .55,
            height: screenHeight * .3,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent.withOpacity(.2),
              image: DecorationImage(
                image: AssetImage(
                  image,
                ),
                fit: BoxFit.cover,
//                  colorFilter: ColorFilter.mode(
//                      Colors.black.withOpacity(.1), BlendMode.),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

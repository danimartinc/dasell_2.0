import 'package:DaSell/data/categories.dart';
import 'package:flutter/material.dart';

import '../../const/colors.dart';

class StoryCategoryItem extends StatelessWidget {
  final String? img;

  //final String name;
  final int index;

  const StoryCategoryItem({
    Key? key,
    required this.index,
    this.img,
    //required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cats = Categories.categories[index];
    var color = Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.only(right: 20, bottom: 10),
      child: Column(
        children: <Widget>[
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                color.withOpacity(0.40),
                color.withOpacity(0.5),
                color.withOpacity(0.6),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(10),
              // border: Border.all(
              //   color: Theme.of(context).primaryColor,
              //   width: 1,
              // ),
            ),
            /*decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: storyBorderColor
            ),
          ),*/
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: 65,
                height: 65,
                child: Icon(
                  cats["icon"],
                  size: 45,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: black, width: 2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            width: 70,
            child: Text(
              cats['category'],
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: white),
            ),
          ),
        ],
      ),
    );
  }
}
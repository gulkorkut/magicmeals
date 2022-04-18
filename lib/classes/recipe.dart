
import 'package:flutter/cupertino.dart';

class Recipe with ChangeNotifier {
  String title;
  String imageUrl;
  int ratings;
  int ratingCount;
  //comments

  Recipe({
    required this.title,
    required this.imageUrl,
    required this.ratings,
    required this.ratingCount

  });

}


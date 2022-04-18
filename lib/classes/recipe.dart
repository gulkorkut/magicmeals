
import 'package:flutter/cupertino.dart';

class Recipe with ChangeNotifier {
  int id;
  String title;
  String imageUrl;
  int ratings;
  int ratingCount;
  //description
  //comments
  //preparation

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.ratings,
    required this.ratingCount

  });

}


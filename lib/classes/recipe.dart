
import 'package:flutter/cupertino.dart';

class Recipe with ChangeNotifier {
  int id;
  String title;
  String imageUrl;
  String description;
  //ingredients
  String preparation;
  int ratings;
  int ratingCount;
  List<Map<String, dynamic>> comments = <Map<String,dynamic>> [
      {
      'commenter': '',
      'comment' : ''
      }
    ];
  //description
  //comments
  //preparation

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.preparation,
    required this.imageUrl,
    required this.ratings,
    required this.ratingCount

  });

}


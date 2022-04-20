
import 'dart:convert';
import 'package:magicmeals202/classes/comment.dart';

import 'package:flutter/cupertino.dart';

/*class Recipe with ChangeNotifier {
  String id;
  String title;
  String imageUrl;
  String description;
  String ingredients;
  String preparation;
  double ratings;
  int ratingCount;
  List<Map<String, dynamic>> comments = <Map<String,dynamic>> [
      {
      'commenter': '',
      'comment' : '',
      }
    ];

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.preparation,
    required this.imageUrl,
    required this.ratings,
    required this.ratingCount
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      ingredients : json['ingredients'] as String,
      preparation: json['preparation'] as String,
      imageUrl: json['imageURL'] as String,
      ratings: json['ratings'] as double,
      ratingCount: json['ratingCount'] as int,
    );
  }

}
*/

Magicmeals202DefaultRtdbExport magicmeals202DefaultRtdbExportFromJson(String str) => Magicmeals202DefaultRtdbExport.fromJson(json.decode(str));

String magicmeals202DefaultRtdbExportToJson(Magicmeals202DefaultRtdbExport data) => json.encode(data.toJson());

class Magicmeals202DefaultRtdbExport {
  Magicmeals202DefaultRtdbExport({
    required this.recipes,
  });

  Map<String, Recipe> recipes;

  factory Magicmeals202DefaultRtdbExport.fromJson(Map<String, dynamic> json) => Magicmeals202DefaultRtdbExport(
    recipes: Map.from(json["recipes"]).map((k, v) => MapEntry<String, Recipe>(k, Recipe.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "recipes": Map.from(recipes).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class Recipe with ChangeNotifier {
  Recipe({
    required this.comments,
    required this.description,
    required this.id,
    required this.imageUrl,
    required this.ingredients,
    required this.preparation,
    required this.ratingCount,
    required this.ratings,
    required this.title,
  });

  List<Comment> comments;
  String description;
  String id;
  String imageUrl;
  String ingredients;
  String preparation;
  int ratingCount;
  int ratings;
  String title;

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    description: json["description"],
    id: json["id"] == null ? null : json["id"],
    imageUrl: json["imageURL"],
    ingredients: json["ingredients"],
    preparation: json["preparation"],
    ratingCount: json["ratingCount"],
    ratings: json["ratings"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
    "description": description,
    "id": id == null ? null : id,
    "imageURL": imageUrl,
    "ingredients": ingredients,
    "preparation": preparation,
    "ratingCount": ratingCount,
    "ratings": ratings,
    "title": title,
  };
}


import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../classes/recipe.dart';

class RecipeDetailed extends StatefulWidget {
  const RecipeDetailed({Key? key}) : super(key: key);

  @override
  _RecipeDetailedState createState() => _RecipeDetailedState();
}

class _RecipeDetailedState extends State<RecipeDetailed> {
  @override
  int _ratingValue = 0;
  int count = 0;

  Widget build(BuildContext context) {
    final recipe = Provider.of<Recipe>(context, listen: false);
    DatabaseReference ref = FirebaseDatabase.instance.ref("recipes/");
    count = recipe.ratingCount;
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: Column(
                  children: <Widget> [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Details for ' + recipe.title,
                          style: const TextStyle(
                            color: Color.fromRGBO(255, 138, 120, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        '⭐ ' + (_ratingValue/recipe.ratingCount).toStringAsFixed(2) + ' (' + count.toString() + ')' != null
                            ?  '⭐ '+ (recipe.ratings/recipe.ratingCount).toStringAsFixed(2) + ' (' + count.toString() + ')'
                            : 'Rate it!',
                        style: const TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                    SizedBox(height: 15,),
                    ClipRRect(
                      child: Image.network(recipe.imageUrl),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1,
                          child: RatingBar(
                              initialRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              ratingWidget: RatingWidget(
                                  full: const Icon(Icons.star,
                                      size: 15, color: Colors.black),
                                  half: const Icon(
                                    Icons.star_half,
                                    size: 15,
                                    color: Colors.black,
                                  ),
                                  empty: const Icon(
                                    Icons.star_outline,
                                    size: 15,
                                    color: Colors.black,
                                  )),
                              onRatingUpdate: (value) {
                                setState(() {
                                  _ratingValue = value.toInt();
                                });
                              }),
                        ),
                        SizedBox(width: 1,),
                        TextButton(
                            onPressed: (){
                              setState(() {
                                if (_ratingValue != null) {
                                  ref.child("/" + recipe.id)
                                    ..child("ratings").set(
                                        ServerValue.increment(_ratingValue));
                                  ref.child("/" + recipe.id)
                                    ..child("ratingCount").set(
                                        ServerValue.increment(1));
                                }
                              });
                            },
                            child: const Text("Rate this recipe!")),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Description',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      recipe.description,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Ingredients',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    recipe.ingredients != null
                        ? Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: Text(
                          recipe.ingredients,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    )
                        : const Text(
                      '',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Preparation',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      recipe.preparation,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    IconButton(
                      onPressed: (){
                        Navigator.pushNamed(context, "/comments_page");
                      },
                      icon: const Icon(
                        Icons.chat,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}

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

  Widget build(BuildContext context) {
    final recipe = Provider.of<Recipe>(context, listen: false);
    DatabaseReference ref = FirebaseDatabase.instance.ref("recipes/");
    return Scaffold(
        appBar: AppBar(
          title: Text(recipe.title),
          actions: <Widget>[
            IconButton(
                onPressed: (){
                  Navigator.pushNamed(context, "/comments_page");
                },
                icon: const Icon(
              Icons.chat,
            ))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Center(
              child: Column(
                children: [
                  ClipRRect(
                    child: Image.network(recipe.imageUrl),
                  ),
                  const SizedBox(height: 15),
                  Text("Description: "+recipe.description, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Text("Ingredients: "+recipe.ingredients,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  Text("Preparation: "+recipe.preparation,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  // description,preparation etc will be here
                  const Text(
                    'Rate',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 25),
                  // implement the rating bar

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
                      SizedBox(width: 15,),
                      TextButton(
                          onPressed: (){
                            if (_ratingValue != null) {
                              ref.child("/" + recipe.id)
                                ..child("ratings").set(
                                    ServerValue.increment(_ratingValue));
                              ref.child("/" + recipe.id)
                                ..child("ratingCount").set(
                                    ServerValue.increment(1));

                            }

                      },
                          child: const Text("Rate this recipe!"))
                    ],
                  ),
                  //const SizedBox(height: 25),
                  // Display the rate in number
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          _ratingValue != null
                              ? "Total Rating:    "+recipe.ratings.toString()
                              : 'Rate it!',
                          style: const TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                      SizedBox(width: 150,),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        alignment: Alignment.bottomRight,
                        child: Text(
                          recipe.ratingCount != null
                              ? "Rating Count: "+recipe.ratingCount.toString()
                              : 'Rate it!',
                          style: const TextStyle(color: Colors.black, fontSize: 20),
                        )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}

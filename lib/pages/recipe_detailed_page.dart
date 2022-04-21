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
  double? _ratingValue;

  Widget build(BuildContext context) {
    final recipe = Provider.of<Recipe>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text(recipe.title),
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
                            _ratingValue = value;
                          });
                        }),
                  ),
                  const SizedBox(height: 25),
                  // Display the rate in number
                  Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                        color: Colors.black, shape: BoxShape.circle),
                    alignment: Alignment.center,
                    child: Text(
                      _ratingValue != null
                          ? _ratingValue.toString()
                          : 'Rate it!',
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}

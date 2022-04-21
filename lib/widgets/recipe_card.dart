

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../classes/recipe.dart';

class RecipeCard extends StatelessWidget {
  final String id;
  final String title;
  final String imgURL;//url for now
  final String description;
  final String ingredients;
  final String preparation;
  final int ratings;
  final int ratingCount;
  final double height;
  final double width;

   const RecipeCard(
      this.id,
      this.title,
      this.imgURL,
      this.description,
      this.ingredients,
      this.preparation,
      this.ratings,
      this.ratingCount,
      this.height,
      this.width,
      );



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<Recipe>(context, listen: false).id=id;
        Provider.of<Recipe>(context, listen: false).title=title;
        Provider.of<Recipe>(context, listen: false).imageUrl=imgURL;
        Provider.of<Recipe>(context, listen: false).description=description;
        Provider.of<Recipe>(context, listen: false).ingredients=ingredients;
        Provider.of<Recipe>(context, listen: false).preparation=preparation;
        Provider.of<Recipe>(context, listen: false).ratings=ratings;
        Provider.of<Recipe>(context, listen: false).ratingCount=ratingCount;


        Navigator.pushNamed(context, '/detailed_page');
      },
      child: Container(
          height: height ,
          width: width ,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: NetworkImage(imgURL),
                fit:BoxFit.cover
            ),
          ),
          child: Card(
            color: Colors.transparent,
            //shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: Text(title,
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
            )
          )
      ),
    );
  }
}


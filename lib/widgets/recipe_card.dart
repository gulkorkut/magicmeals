

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../classes/recipe.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final String imgURL;//url for now
  final double? height;
  final double? width;

  const RecipeCard(
      this.title,
      this.imgURL,
      this.height,
      this.width,
      );



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<Recipe>(context, listen: false).title=title;
        Provider.of<Recipe>(context, listen: false).imageUrl=imgURL;
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


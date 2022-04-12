

import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String? title;
  final String? imgURL;//url for now
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
      onTap: (){} ,// will open the detailed recipe page
      borderRadius: BorderRadius.circular(20),
      child: Column(
        children: [
          const Text(
            "Pizza",
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          Ink.image(
            fit: BoxFit.cover,
            width: 200,
            height: 100,
            image: const NetworkImage("https://cdn.yemek.com/mncrop/600/315/uploads/2017/01/ev-usulu-pizza-yeni.jpg"),
          ),
        ],
      ),

    );
  }}
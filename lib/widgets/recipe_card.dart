

import 'package:flutter/material.dart';

class RecipeCard extends StatelessWidget {
  final String title;
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
      onTap: () {},
      child: Container(
          height: height ,
          width: width ,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: NetworkImage("https://cdn.yemek.com/mncrop/600/315/uploads/2017/01/ev-usulu-pizza-yeni.jpg"),
                fit:BoxFit.cover
            ),
          ),
          child: Card(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            shadowColor: Colors.grey,
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


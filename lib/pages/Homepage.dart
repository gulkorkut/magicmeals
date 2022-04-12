

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magicmeals202/widgets/recipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Page",
          style: TextStyle(),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemCount: 5,
          itemBuilder: (BuildContext context, int index){
            return RecipeCard("Pizza","",100,300);
          }
          ),
    );
  }


}



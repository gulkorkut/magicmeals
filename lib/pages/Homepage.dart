import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magicmeals202/widgets/recipe_card.dart';

import '../classes/recipe.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe> recipes = [];





  Future<void> getRecipesFromDB() async {

    recipes = [];


    DatabaseReference ref = FirebaseDatabase.instance.ref('/recipes');
    DatabaseEvent event = await ref.once();



    for (DataSnapshot postSnapshot in event.snapshot.children){

      Map<String, dynamic> data = jsonDecode(jsonEncode(postSnapshot.value));
      recipes.add(Recipe.fromJson(data));
      //Recipe sample = Recipe.fromJson(data);
      //print(sample.title);
      //print(postSnapshot.value.runtimeType);
      //print("---");
      //print(Map<String, dynamic>.from(Map<String, dynamic>.from(postSnapshot.value as dynamic)).runtimeType);
      //Recipe sample = Recipe.fromJson(Map<String, dynamic>.from(postSnapshot.value as dynamic));
      //print("----");
      //print(postSnapshot.value.runtimeType);
      //print("---_-------------------------------");
      //recipes.add(jsonDecode(jsonEncode(postSnapshot.value)));
    }
    //print(recipes.length);




    //final decodedData = jsonDecode(jsonEncode(event.snapshot.value));
    //print(decodedData);
    //print(Recipe.fromJson(decodedData));


    //Map<String, dynamic> dataValue = event.snapshot.value as dynamic;

    //recipes = List<Recipe>.from(dataValue['recipes']
    //    .map((x) => Recipe.fromJson(x as dynamic)));

    //final parsed = decodedData.cast<Map<String, dynamic>>();

    //print(parsed);

    //return parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();

    //print(event.snapshot.value);



  }

  /*List<Recipe> parseRecipe(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();
  }
*/

  @override
  Widget build(BuildContext context) {
    getRecipesFromDB();
    return Scaffold(
      backgroundColor: const Color(0xff121421),
      appBar: AppBar(
        backgroundColor: const Color(0xff121421),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add_recipe');
              //Navigator.pushNamed(context, '/add_recipe');
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
        ],
        title: const Text(
          "Home Page",
          style: TextStyle(),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return RecipeCard(
                "Pizza",
                "https://cdn.yemek.com/mncrop/600/315/uploads/2017/01/ev-usulu-pizza-yeni.jpg",
                100,
                300);
          }),
    );
  }
}

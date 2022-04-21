import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magicmeals202/widgets/recipe_card.dart';
import 'package:http/http.dart' as http;

import '../classes/recipe.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<String> titleList = [];
  List<String> imageList = [];
  Future<void> readData() async {

    // Please replace the Database URL
    // which we will get in “Add Realtime Database”
    // step with DatabaseURL

    var url = "https://magicmeals202-default-rtdb.europe-west1.firebasedatabase.app/recipes.json";
    // Do not remove “data.json”,keep it as it is
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((blogId, blogData) {
        titleList.add(blogData["title"]);
        print(titleList.last);
        imageList.add(blogData["imageURL"]);
        print(imageList.last);
      });
      setState(() {
        isLoading = false;
      });
    } catch (error) {

      print(error);
      throw error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }


  @override
  Widget build(BuildContext context) {
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
      body: isLoading
          ? CircularProgressIndicator()
          : ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: titleList.length,
          itemBuilder: (BuildContext context, int index) {
            return RecipeCard(
                titleList[index],
                imageList[index],
                200,
                100);
          }),
    );
  }
}

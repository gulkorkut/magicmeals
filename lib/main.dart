import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:magicmeals202/pages/Homepage.dart';
import 'package:magicmeals202/pages/recipe_detailed_page.dart';
import 'package:magicmeals202/pages/recipe_add_page.dart';
import 'package:magicmeals202/widgets/recipe_card.dart';


void main() {
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/detailed_page": (ctx) => const RecipeDetailed(),
        "/add_recipe": (ctx) => const RecipeAdd(),
      },
      home: HomePage(),
    );
  }
}

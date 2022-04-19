import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:magicmeals202/pages/Homepage.dart';
import 'package:magicmeals202/pages/intro_page.dart';
import 'package:magicmeals202/pages/login_input_page.dart';
import 'package:magicmeals202/pages/login_page.dart';
import 'package:magicmeals202/pages/recipe_detailed_page.dart';
import 'package:magicmeals202/pages/recipe_add_page.dart';
import 'package:magicmeals202/widgets/recipe_card.dart';
import 'package:provider/provider.dart';

import 'classes/recipe.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(
  ));
  
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider<Recipe>(create: (_) => Recipe(
          id: 0,
          title: "Default Food",
          imageUrl: "No URL Provided",
          description: "Default Description",
          preparation: "Default Preparation",
          ratingCount: 0,
          ratings: 0,
        )),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/detailed_page": (ctx) => const RecipeDetailed(),
          "/add_recipe": (ctx) => const RecipeAdd(),
          "/login_page": (ctx) => LoginScreen(),
          "/home_page": (ctx) => const HomePage(),
          "/login_input_page": (ctx) => LoginInputScreen(),
        },
        home: FutureBuilder(
            future: _fbApp,
            builder: (context,snapshot){
              if (snapshot.hasError){
                return Text("An error occured");
              }
              else if (snapshot.hasData){
                return IntroScreen();
              }
              else {
                return CircularProgressIndicator();
              }
            }
        ),
      ),
    );
  }
}

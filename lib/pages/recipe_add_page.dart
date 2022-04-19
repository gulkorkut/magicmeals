import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecipeAdd extends StatefulWidget {
  const RecipeAdd({Key? key}) : super(key: key);

  @override
  _RecipeAddState createState() => _RecipeAddState();
}

class _RecipeAddState extends State<RecipeAdd> {
  final _imageUrlFocusNode = FocusNode();
  List controllers = List.generate(5, (index) => TextEditingController());
  String URL = "";
  final _form = GlobalKey<FormState>();
  List names = ["Title", "Description", "Ingredients", "Preparation"];
  String temp_title ="";
  String temp_desc ="";
  String temp_ingre ="";
  String temp_prep ="";
  String temp_url ="";

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!controllers[4].text.startsWith('http') &&
          !controllers[4].text.startsWith('https')) ||
          (!controllers[4].text.endsWith('.png') &&
              !controllers[4].text.endsWith('.jpg') &&
              !controllers[4].text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference ref = FirebaseDatabase.instance.ref("recipes/");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff515979),
        title: const Text("Add Recipe"),
        actions: [
          IconButton(
            onPressed: () async {
              temp_title = controllers[0].text;
              temp_desc = controllers[1].text;
              temp_ingre = controllers[2].text;
              temp_prep = controllers[3].text;
              temp_url = controllers[4].text;
              String? newkey = ref.push().key;
              await ref.child(newkey!).set({
                'title' :temp_title,
                'description' : temp_desc,
                'ingredients' : temp_ingre,
                'preparation' : temp_prep,
                'imageURL' : temp_url,
                'ratings': 0,
                'ratingCount' : 0,
                'comments' :[
                {
                  'commenter' : '',
                  'comment' : '',
                }
                ]
              });
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: names.length - 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp("[-]"))
                      ],
                      decoration: InputDecoration(
                        hintText: names[index],
                      ),
                      controller: controllers[index],
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide a description.';
                    }
                    if (value.length < 10) {
                      return 'Should be at least 10 characters long.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: names[3],
                  ),
                  controller: controllers[3],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(
                        top: 8,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                      child: controllers[4].text.isEmpty
                          ? const Text('Enter a URL')
                          : FittedBox(
                        child: Image.network(
                          controllers[4].text,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        onChanged: (_) {
                          _updateImageUrl();
                        },
                        decoration:
                        const InputDecoration(labelText: 'Image URL'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: controllers[4],
                        focusNode: _imageUrlFocusNode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an image URL.';
                          }
                          if (!value.startsWith('http') &&
                              !value.startsWith('https')) {
                            return 'Please enter a valid URL.';
                          }
                          if (!value.endsWith('.png') &&
                              !value.endsWith('.jpg') &&
                              !value.endsWith('.jpeg')) {
                            return 'Please enter a valid image URL.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

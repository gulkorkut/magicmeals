
import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController commentCont = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (BuildContext context,int index){
                  return ListTile(
                    title: Text("Default Comment"),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
                itemCount: 4),
          ),
          SizedBox(height: 50,),
          ListTile(
            title: TextFormField(
              controller: commentCont,
              decoration: InputDecoration(labelText: "Write a comment"),
            ),
            trailing: OutlinedButton(
                onPressed: (){

                },
                child: const Text("Save comment")),
          )

        ],
      ),
    );
  }
}

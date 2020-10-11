// Importing the necessary packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/database.dart';

import 'auth.dart';
import 'post.dart';
import 'post_list.dart';
import 'text_input_widget.dart';

class HomePage extends StatefulWidget {
  final User user;

  HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> posts = [];

  void newPost(String text) {
    var post = new Post(text, this.widget.user.displayName);
    post.setId(savePost(post));
    this.setState(() {
      posts.add(post);
    });
  }

  void updatePosts() {
    getAllMessages().then((posts) => {
          this.setState(() {
            this.posts = posts;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    updatePosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Team Colab"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.exit_to_app),
                splashColor: Colors.blue,
                tooltip: "Signout",
                onPressed: () => {signOutGoogle(), Navigator.pop(context)})
          ],
        ),
        body: Column(children: <Widget>[
          Expanded(child: PostList(this.posts, this.widget.user)),
          TextInputWidget(this.newPost)
        ]));
  }
}

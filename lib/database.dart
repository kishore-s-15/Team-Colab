// Importing the necessary packages
import 'package:firebase_database/firebase_database.dart';

import 'post.dart';

// Firebase Database reference
final databaseReference = FirebaseDatabase.instance.reference();

DatabaseReference savePost(Post post) {
  var id = databaseReference.child('posts/').push();
  id.set(post.toJSON());

  return id;
}

void updatePost(Post post, DatabaseReference id) {
  id.update(post.toJSON());
}

Future<List<Post>> getAllMessages() async {
  DataSnapshot dataSnapshot = await databaseReference.child('posts/').once();
  List<Post> posts = [];

  if (dataSnapshot.value != null) {
    dataSnapshot.value.forEach((key, value) {
      Post post = createPost(value);
      post.setId(databaseReference.child('posts/' + key));
      posts.add(post);
    });
  }

  return posts;
}

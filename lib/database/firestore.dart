import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*
 * this db stores posts that users have published in the app
 * It is stored in a collection called Posts in firebase db
 * Each post contains a message, email of user who posted it and timestamp 
 * 
*/

class FirestoreDatabase {
  // current logged in user
  User? user = FirebaseAuth.instance.currentUser;

  // get collection of posts from Firestore
  final CollectionReference posts = FirebaseFirestore.instance.collection('Posts');

  // post a message | Add to posts collection
  Future<void> addPost(String message) {
    return posts.add({
      'userEmail': user!.email,
     'message': message,
     'timestamp': Timestamp.now()
    });
  }

  // read posts from the database
  Stream<QuerySnapshot> getPostsStream() {
    return posts.orderBy('timestamp', descending: true).snapshots();
  }
}
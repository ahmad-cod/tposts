import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia_demo/components/my_drawer.dart';
import 'package:socialmedia_demo/components/my_list_tile.dart';
import 'package:socialmedia_demo/components/my_post_button.dart';
import 'package:socialmedia_demo/components/my_textfield.dart';
import 'package:socialmedia_demo/database/firestore.dart';
import 'package:socialmedia_demo/helper/helper_functions.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // firestore access
  final FirestoreDatabase database = FirestoreDatabase();
  final TextEditingController newPostController = TextEditingController();

  void postMessage() {
    String message = newPostController.text;
    // only post message if textfield is not empty
    if (message.isNotEmpty) {
      database.addPost(message);
    }

    newPostController.clear();
  }

  void logout () {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        centerTitle: true,
        title: const Text('T A Q W A'),
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: MyTextfield(
                    hintText: 'what\'s happening',
                    obscureText: false,
                    controller: newPostController)
                ),
                PostButton(
                  onTap: postMessage,
                ),
              ],
            ),
          ),

          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                alertUser('Error: ${snapshot.error}', context);
              }

              // all posts
              final posts = snapshot.data!.docs;

              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text('No posts... Post Something'),
                  ),
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    // get individual posts
                    final post = posts[index];

                    // get data for each post
                    String message = post['message'];
                    String userEmail = post['userEmail'];
                    // Timestamp timestamp = post['timestamp'];

                    // return as a list tile
                    return MyListTile(title: message, subTitle: userEmail);
                  }
                )
              );
            }
          )
        ],
      ),
    );
  }
}
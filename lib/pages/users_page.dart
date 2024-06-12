import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia_demo/components/my_back_button.dart';
import 'package:socialmedia_demo/components/my_list_tile.dart';
import 'package:socialmedia_demo/helper/helper_functions.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  // get all users and return them in a list view builder list tile

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Users'),
      // ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(), 
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            alertUser('Error: ${snapshot.error}', context);
          }
          else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (snapshot.data == null) {
            return const Text('No data available');
          }

          // get all users
          final users = snapshot.data!.docs;

          return Column(
            children: [
              const Padding(
                    padding: EdgeInsets.only(top: 10, left: 20),
                    child: Row(
                      children: [
                        MyBackButton(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25,),

              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    // get individual user
                    final user = users[index];
                
                    // get data from each user
                    String username = user['username'];
                    String email = user['email'];
                
                    return MyListTile(title: username, subTitle: email);
                  }
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}

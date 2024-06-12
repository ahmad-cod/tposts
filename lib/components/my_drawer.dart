import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout () {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                    child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // logo
                    Icon(
                      Icons.person,
                      size: 80,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                
                    const SizedBox(
                      height: 25,
                    ),
                
                    // app name
                    const Text(
                      'T A Q W A',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                )),
                const SizedBox(height: 40,),
                
                
                // home
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: const Text('H O M E'),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.pushNamed(context, '/home_page');
                  },
                ),
                const SizedBox(height: 40,),
                
                // profile
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: const Text('P R O F I L E'),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.pushNamed(context, '/profile_page');
                  },
                ),
                const SizedBox(height: 40,),
                
                // users page
                ListTile(
                  leading: Icon(
                    Icons.group,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: const Text('U S E R S'),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.pushNamed(context, '/users_page');
                  },
                ),
              ],
            ),

            // logout tile
             Padding(
               padding: const EdgeInsets.only(left: 5.0, bottom: 20),
               child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                title: const Text('L O G O U T'),
                onTap: () {
                  Navigator.pop(context);
                  logout();
                },
                           ),
             ),
            
          ],
        ),
      ),
    );
  }
}

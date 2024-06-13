import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia_demo/components/my_button.dart';
import 'package:socialmedia_demo/components/my_textfield.dart';
import 'package:socialmedia_demo/helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text controllers
  TextEditingController usernameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  // login method
  void registerUser(BuildContext context) async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      )
    );

    // make sure password and confirm password match
    if (passwordController.text != confirmPasswordController.text) {
      // pop out the loading circle
      Navigator.pop(context);

      passwordController.clear();
      confirmPasswordController.clear();
      // display message to user about the error
      alertUser("Passwords don't match!", context);
    }

   else {
     // try creating user
    try {
      // create the user
      UserCredential? usercredential = 
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // create a user document and add to firestore
      createUserDocument(usercredential);

      if (!context.mounted) return;
      // pop loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop out the loading circle
      Navigator.pop(context);

      // display message to user about the error
      alertUser(e.code, context);
    }
   }
  }

  // create a user document in firestore
  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      // create a user document in firestore
      await FirebaseFirestore.instance.collection('Users')
      .doc(userCredential.user!.email)
      .set({
        'email': userCredential.user!.email,
        'username': usernameController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              const SizedBox(
                height: 25,
              ),

              // username textfield
              MyTextfield(
                hintText: "username",
                obscureText: false,
                controller: usernameController,
              ),
              const SizedBox(
                height: 10,
              ),


              // email textfield
              MyTextfield(
                hintText: "Email",
                obscureText: false,
                controller: emailController,
              ),
              const SizedBox(
                height: 10,
              ),

              // password textfield
              MyTextfield(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController),

              const SizedBox(height: 10),

              MyTextfield(
                  hintText: "Confirm Password",
                  obscureText: true,
                  controller: confirmPasswordController),

              const SizedBox(height: 25),
          
              // Register button
              MyButton(text: 'Register', onTap: () => registerUser(context)),
              const SizedBox(height: 25),

              // if you aren't registered, you can sign up here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: widget.onTap,
                    child: const Text(
                      'Login Here!',
                      style: TextStyle(
                          // color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

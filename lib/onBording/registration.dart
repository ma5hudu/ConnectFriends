import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_friends/homePage.dart';
import 'package:connect_friends/model/user_view_model.dart';
import 'package:connect_friends/model/users_.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  _openHomePage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const HomePage();
    }));
  }

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Perform user registration and send email verification
        UserCredential userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Create an instance of Users with user details
        Users currentUser = Users(
          uid: userCredential.user!.uid,
          name: _nameController.text.trim(),
          surname: _surnameController.text.trim(),
          email: _emailController.text.trim(),
          profilePicture:
              'url_to_default_profile_picture', // You can replace this with the actual URL or leave it as is
        );

        // Store user data in Firestore
        await currentUser.storeUserData();

        // Send verification email
        await userCredential.user!.sendEmailVerification();
      

        _openHomePage(context);
      } catch (e) {
        print('Error during registration: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      hintText: "Enter your name",
                      labelText: "Name:",
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: _surnameController,
                  decoration: const InputDecoration(
                      hintText: "Enter your surname",
                      labelText: "Surname:",
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your surname";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      hintText: "Enter your email",
                      labelText: "Email",
                      border: OutlineInputBorder()),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      hintText: "Enter your password",
                      labelText: "Password",
                      border: OutlineInputBorder()),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: _confirmPasswordController,
                  decoration: const InputDecoration(
                      hintText: "Confirm your password",
                      labelText: "Confrim Password",
                      border: OutlineInputBorder()),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != _passwordController.text) {
                      return "Password do not match";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add_a_photo_outlined, size: 20.0),
                    SizedBox(width: 8.0),
                    Text(
                      "Upload a picture",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                  onPressed: () async {
                    _registerUser();
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

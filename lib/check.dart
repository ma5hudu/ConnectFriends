import 'package:connect_friends/model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Make sure to import the UserOperations class

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

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

  // Uncomment this method if you want to navigate to the home page after registration
  // _openHomePage(BuildContext context) {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (context) {
  //     return const HomePage();
  //   }));
  // }

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
              // ... (other form fields)

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      // Perform user registration and send email verification
                      UserCredential userCredential =
                          await _firebaseAuth.createUserWithEmailAndPassword(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );

                      // Send verification email
                      await userCredential.user!.sendEmailVerification();

                      // Register user and store data
                      await UserOperations.registerUser(
                        name: _nameController.text.trim(),
                        surname: _surnameController.text.trim(),
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                        confirmPassword: _confirmPasswordController.text.trim(),
                      );

                      // Uncomment this line if you want to navigate to the home page after registration
                      // _openHomePage(context);
                    } catch (e) {
                      // Handle registration errors
                      print('Error during registration: $e');
                    }
                  }
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

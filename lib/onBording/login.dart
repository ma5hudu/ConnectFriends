import 'package:connect_friends/homePage.dart';
import 'package:connect_friends/onBording/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

 final _formKey = GlobalKey<FormState>();

  _openRegistration(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const RegistrationScreen();
    }));
  }

    _openHomePage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const HomePage();
    }));
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
         backgroundColor: Color.fromARGB(255, 64, 190, 195),
      ),
      body: Center(
        child: Form(
          key: _formKey,
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              width: 400,
              child: Column(
                children: [Text('Welcome to ConnectFriends, please sign in')],
              ),
            ),
            const SizedBox(
              height: 20.0,
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
            ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        _openHomePage(context);
                      } catch (exception) {
                        print('Error during login: $exception');
                        // Display an alert with the error message
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Login Error'),
                              content: Text(
                                  'Invalid email or password. Please try again.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                _openRegistration(context);
              },
              child: const Text(
                'Don\'t have an account? Sign Up',
                style: TextStyle(
                  color: Color.fromARGB(255, 23, 82, 131),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

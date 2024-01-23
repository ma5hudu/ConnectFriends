import 'package:connect_friends/homePage.dart';
import 'package:connect_friends/onBording/login.dart';
import 'package:connect_friends/onBording/registration.dart';
import 'package:flutter/material.dart';

class MyFirstPage extends StatefulWidget {
  const MyFirstPage({super.key, required this.title});

  final String title;

  @override
  State<MyFirstPage> createState() => _MyFirstPageState();
}

class _MyFirstPageState extends State<MyFirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.grey,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 16.0,
          ),
          Image.asset(
            "assets/images/logo.png",
            width:800,
            height: 400,
          ),
          const SizedBox(
            height: 16.0,
          ),
          ElevatedButton(
              onPressed: () {
                _openLoginPage(context);
              },
              child: const Text(
                'Connect with friends',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ))
        ],
      )),
    );
  }
  _openLoginPage(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return  const SignInPage();
    }));

  }
}

import 'package:flutter/material.dart';

class MyNotifications extends StatefulWidget {
  const MyNotifications({super.key});

  @override
  State<MyNotifications> createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications'
          ),
          backgroundColor: Color.fromARGB(255, 64, 190, 195),
          ),
          body: Center(child: Column(children: <Widget>[
            ListTile(
               title: Text("title"),
               subtitle: Text("fr"),
            ),
            ListTile(
               title: Text("Body"),
               subtitle: Text("fr"),
            )
          ]),)
    );
  }
}
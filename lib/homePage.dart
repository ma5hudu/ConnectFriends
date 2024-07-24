import 'package:connect_friends/model/user_view_model.dart';
import 'package:connect_friends/onBording/login.dart';
import 'package:connect_friends/pages/friend_requests.dart';
import 'package:connect_friends/pages/my_profile.dart';
import 'package:connect_friends/pages/notifications.dart';
import 'package:connect_friends/pages/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        leading: IconButton(
            icon: const Icon(Icons.login_outlined),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const SignInPage();
              }));
            }),
        backgroundColor: Color.fromARGB(255, 64, 190, 195),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ChangeNotifierProvider(
                            create: (context) => UserViewMode(),
                            child: const UserProfile(),
                          );
                        },
                      ),
                    );
                  },
                  child: Text('Profile'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ChangeNotifierProvider(
                            create: (context) => UserViewMode(),
                            child: const SearchUsers(),
                          );
                        },
                      ),
                    );
                  },
                  child: Text('Global users'),
                ),
              ],
            ),
            const SizedBox(height: 16.0), // Adjust the space between rows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ChangeNotifierProvider(
                            create: (context) => UserViewMode(),
                            child: const Requests(),
                          );
                        },
                      ),
                    );
                  },
                  child: Text('Friend Request'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ChangeNotifierProvider(
                            create: (context) => UserViewMode(),
                            child: const MyNotifications(),
                          );
                        },
                      ),
                    );
                  },
                  child: Text('My Notifications'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



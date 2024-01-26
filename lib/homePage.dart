import 'package:connect_friends/model/user_view_model.dart';
import 'package:connect_friends/pages/my_profile.dart';
import 'package:connect_friends/pages/search.dart';
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
                  child: Text('Search'),
                ),
              ],
            ),
           const SizedBox(height: 16.0), // Adjust the space between rows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle button 3
                  },
                  child: Text('Friends'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle button 4
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

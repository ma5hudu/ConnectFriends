import 'dart:html';

import 'package:connect_friends/homePage.dart';
import 'package:connect_friends/model/user_view_model.dart';
import 'package:connect_friends/model/users_.dart';
import 'package:connect_friends/pages/friend_profile.dart';
import 'package:connect_friends/pages/my_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchUsers extends StatefulWidget {
  const SearchUsers({super.key});

  @override
  State<SearchUsers> createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
  TextEditingController _searchController = TextEditingController();

  late Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getUsersNameStreamSnapshots();
  }

  _onSearchChanged() {
    searchResultsList();
  }

  searchResultsList() {
    var showResults = [];

    if (_searchController.text != "") {
      for (var users in _allResults) {
        var name = users.name.toLowerCase();

        if (name.contains(_searchController.text.toLowerCase()) &&
            users.uid != FirebaseAuth.instance.currentUser?.uid) {
          showResults.add(users);
        }
      }
    } else {
      showResults = _allResults
          .where((user) => user.uid != FirebaseAuth.instance.currentUser?.uid)
          .toList();
    }
    setState(() {
      _resultsList = showResults;
    });
  }

  getUsersNameStreamSnapshots() async {
    // Assuming liftsViewModel is an instance of LiftsViewModel
    await Provider.of<UserViewMode>(context, listen: false)
        .loadRegisteredUser();
    setState(() {
      _allResults = Provider.of<UserViewMode>(context, listen: false).users;
    });
    searchResultsList();
    return "complete";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Global Users"),
        leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const HomePage();
              }));
            }),
        backgroundColor: Color.fromARGB(255, 64, 190, 195),
      ),
      body: Consumer<UserViewMode>(builder: (context, userModel, child) {
        if (userModel.users.isEmpty) {
          userModel.loadRegisteredUser();
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          List<Users> otherUsers = userModel.users
              .where(
                  (user) => user.uid != FirebaseAuth.instance.currentUser!.uid)
              .toList();

          return Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 400,
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                        hintText: "Search for global user",
                        prefixIcon: Icon(Icons.search_outlined)),
                  ),
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: ListView.builder(
                      itemCount: _resultsList.length,
                      itemBuilder: (context, index) {
                        final user = _resultsList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return ChangeNotifierProvider(
                                    create: (context) => UserViewMode(),
                                    child: OtherUserProfile(selectedUser: user),
                                  );
                                },
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(
                              "${user.name} ${user.surname}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          );
        }
      }),
    );
  }
}

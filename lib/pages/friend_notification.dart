import 'package:connect_friends/model/user_view_model.dart';
import 'package:connect_friends/onBording/login.dart';
import 'package:connect_friends/pages/notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isInvitationAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        leading: IconButton(
            icon: const Icon(Icons.login_outlined),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const SignInPage();
              }));
            }),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
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
          ),
        ],
        backgroundColor: Color.fromARGB(255, 64, 190, 195),
      ),
      body: Consumer<UserViewMode>(
        builder: (context, userViewModel, child) {
          // Check if user details are loaded
          if (userViewModel.currentUser == null) {
            // User details are not loaded, fetch them
            userViewModel.loadUserDetails();
            return Center(child: CircularProgressIndicator());
          }

          // User details are loaded, display them
          final currentUser = userViewModel.currentUser!;

          return ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    const CircleAvatar(
                      radius: 60.0,
                      child: Icon(
                        Icons.person,
                        size: 20.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      '${currentUser.name} ${currentUser.surname}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      '${currentUser.email}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: isInvitationAccepted
                          ? null
                          : () async {
                              await userViewModel.inviteFriends
                                  .acceptInvitation(currentUser);
                              setState(() {
                                isInvitationAccepted = true;
                              });
                            },
                      child: const Text('Accept invitation'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

mixin instance {}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_friends/model/user_view_model.dart';
import 'package:connect_friends/model/users_.dart';
import 'package:connect_friends/pages/friend_notification.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyNotifications extends StatefulWidget {
  const MyNotifications({Key? key}) : super(key: key);

  @override
  State<MyNotifications> createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> {
  late UserViewMode userViewModel;

  @override
  void initState() {
    super.initState();
    userViewModel = Provider.of<UserViewMode>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Color.fromARGB(255, 64, 190, 195),
      ),
      body: FutureBuilder<void>(
        future: userViewModel.loadUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading user details'));
          } else {
            return Consumer<UserViewMode>(
              builder: (context, userViewModel, child) {
                Users? currentUser = userViewModel.currentUser;

                if (currentUser == null) {
                  print('currentUser is null');
                  // show a loading indicator or handle the case where user details are not loaded yet.
                  return Center(child: CircularProgressIndicator());
                }

                return NotificationList(
                    userViewModel: userViewModel, currentUser: currentUser);
              },
            );
          }
        },
      ),
    );
  }
}

class NotificationList extends StatelessWidget {
  final UserViewMode userViewModel;
  final Users currentUser;

  const NotificationList({
    Key? key,
    required this.userViewModel,
    required this.currentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future:
          userViewModel.requestManager.getNotificationMessages(currentUser.uid),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<Map<String, dynamic>> notifications = snapshot.data!;
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                var data = notifications[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ChangeNotifierProvider(
                            create: (context) => UserViewMode(),
                            child: const Profile(),
                          );
                        },
                      ),
                    );
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        title: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(data['message'] ?? ''),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No notifications available.'));
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

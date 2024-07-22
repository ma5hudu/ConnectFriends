import 'package:connect_friends/model/user_view_model.dart';
import 'package:connect_friends/model/users_.dart';
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
        backgroundColor: const Color.fromARGB(255, 64, 190, 195),
      ),
      body: FutureBuilder<void>(
        future: userViewModel.loadUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading user details'));
          } else {
            return Consumer<UserViewMode>(
              builder: (context, userViewModel, child) {
                Users? currentUser = userViewModel.currentUser;

                if (currentUser == null) {
                  return const Center(
                      child: Text('No user details available.'));
                }

                return NotificationList(
                  userViewModel: userViewModel,
                  currentUser: currentUser,
                );
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

  /// Code within futureBuilder makes sure that the data is loaded
  /// from database and once it is availabe it uses listview builder to display
  /// each notification in a card.
  /// If the future is loading an error or no data is found the user will get the message


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future:
          userViewModel.requestManager.getNotificationMessages(currentUser.uid),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print('Error in FutureBuilder: ${snapshot.error}');
          return const Center(child: Text('Error loading notifications.'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No notifications available.'));
        } else {
          List<Map<String, dynamic>> notifications = snapshot.data!;
          print('Notifications loaded: ${notifications.length}');
          notifications.forEach((notification) {
            print('Notification: $notification');
          });

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              var data = notifications[index];
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(data['message'] ?? 'No message'),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

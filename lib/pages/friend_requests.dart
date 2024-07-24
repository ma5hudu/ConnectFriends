import 'package:connect_friends/model/friend_request.dart';
import 'package:connect_friends/model/friend_request_manager.dart';
import 'package:connect_friends/model/user_view_model.dart';
import 'package:connect_friends/model/users_.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
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
        title: const Text('Friend Requests'),
        backgroundColor: const Color.fromARGB(255, 64, 190, 195),
      ),
      body: Consumer<UserViewMode>(
        builder: (context, userViewModel, child) {
          final currentUser = userViewModel.currentUser;

          if (currentUser == null) {
            userViewModel.loadUserDetails();
            return const Center(child: CircularProgressIndicator());
          }

          return FutureBuilder<List<FriendRequest>>(
            future:
                userViewModel.requestManager.loadFriendRequest(currentUser.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                    child: Text('Error loading friend requests'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text('No friend requests available.'));
              } else {
                final friendRequests = snapshot.data!;
                return ListView.builder(
                  itemCount: friendRequests.length,
                  itemBuilder: (context, index) {
                    final request = friendRequests[index];
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.person_rounded),
                        title: Text(
                            '${request.requesterName} ${request.requesterSurname}'),
                        subtitle: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Handle accept friend request
                              },
                              child: const Text('Accept'),
                            ),
                            const SizedBox(width: 8.0),
                            ElevatedButton(
                              onPressed: () {
                                // Handle decline friend request
                              },
                              child: const Text('Decline'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}

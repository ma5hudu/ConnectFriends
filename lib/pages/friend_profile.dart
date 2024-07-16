import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_friends/model/user_view_model.dart';
import 'package:connect_friends/model/users_.dart';
import 'package:connect_friends/model/friend_request.dart';
import 'package:connect_friends/model/friend_request_manager.dart';
import 'package:flutter/material.dart';

class OtherUserProfile extends StatefulWidget {
  final Users selectedUser;
  const OtherUserProfile({Key? key, required this.selectedUser})
      : super(key: key);

  @override
  State<OtherUserProfile> createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends State<OtherUserProfile> {
  UserViewMode userViewModel = UserViewMode();
  FriendRequestManager friendRequestManager = FriendRequestManager();
  bool isFriendRequestSent = false;
  bool isFriendRequestAccepted = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initializeProfile();
  }

  Future<void> initializeProfile() async {
    await loadCurrentUser();
    await checkRequestStatus();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> loadCurrentUser() async {
    await userViewModel.loadUserDetails();
  }

  Future<void> checkRequestStatus() async {
    Users? currentUser = userViewModel.currentUser;
    if (currentUser == null) return;

    String friendId = widget.selectedUser.uid;
    bool requestSent =
        await friendRequestManager.isRequestSent(currentUser.uid, friendId);

    // Check if the friend request is sent
    // QuerySnapshot sentRequestSnapshot = await FirebaseFirestore.instance
    //     .collection('friendRequests')
    //     .where('requesterUid', isEqualTo: currentUser.uid)
    //     .where('reciverUid', isEqualTo: friendId)
    //     .get();

    setState(() {
      isFriendRequestSent = requestSent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.displaySmall,
        ),
        backgroundColor: Color.fromARGB(255, 64, 190, 195),
      ),
      body: ListView(
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
                  '${widget.selectedUser.name} ${widget.selectedUser.surname}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  widget.selectedUser.email,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () async {
                    await loadCurrentUser();
                    Users currentUser = userViewModel.currentUser!;
                    String friendId = widget.selectedUser.uid;

                    if (isFriendRequestSent && !isFriendRequestAccepted) {
                      // Accept the friend request
                      print('Accepting friend request...');
                      await friendRequestManager.acceptFriendRequest(
                          currentUser.uid, friendId);
                      await checkRequestStatus();
                    } else if (!isFriendRequestSent) {
                      // Send a friend request
                      print('Sending friend request...');
                      await friendRequestManager.sendFriendRequest(
                          currentUser, widget.selectedUser);
                      setState(() {
                        isFriendRequestSent = true;
                      });
                      await checkRequestStatus();
                    }
                  },
                  child: Text(
                    isFriendRequestSent
                        ? (isFriendRequestAccepted ? 'Friends' : 'Request Sent')
                        : 'Add Friend',
                  ),
                ),
                const SizedBox(height: 20.0),
                isFriendRequestSent && !isFriendRequestAccepted
                    ? ElevatedButton(
                        onPressed: () async {
                          // Cancel friend request
                          await loadCurrentUser();
                          Users currentUser = userViewModel.currentUser!;
                          await friendRequestManager.cancelFriendRequest(
                              currentUser.uid, widget.selectedUser.uid);
                          setState(() {
                            isFriendRequestSent = false;
                          });
                        },
                        child: const Text("Cancel request"))
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:connect_friends/model/users_.dart';
// import 'package:flutter/material.dart';

// class InviteFriends extends ChangeNotifier {
//   Future<void> sendFriendRequestWithNotification(
//       Users currentUser, String friendId) async {
//     try {
//       // Update friend requests in Firestore
//       currentUser.friendRequest.add(friendId);
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(friendId)
//           .update({
//         'friendRequests': FieldValue.arrayUnion([currentUser.uid])
//       });

  //     // Send a notification to the selected user
  //     String notificationMessage =
  //         '${currentUser.name} sent you a friend request.';
  //     await FirebaseFirestore.instance.collection('notifications').add({
  //       'userId': friendId,
  //       'message': notificationMessage,
  //       'timestamp': FieldValue.serverTimestamp(),
  //     });

  //     notifyListeners();
  //   } catch (e) {
  //     print('Error sending friend request: $e');
  //   }
  // }

  // Future<List<Map<String, dynamic>>> getNotificationMessages(
  //     String userId) async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
  //         .instance
  //         .collection('notifications')
  //         .where('userId', isEqualTo: userId)
  //         .orderBy('timestamp', descending: true)
  //         .get();

  //     return snapshot.docs
  //         .map((doc) => doc.data() as Map<String, dynamic>)
  //         .toList();
  //   } catch (e) {
  //     print('Error loading notification messages: $e');
  //     return []; // Handle the error appropriately
  //   }
  // }

//   Future<void> friendshipStatus() async {}

//   // Future<void> acceptInvitation(Users currentUser) async {
//   //   try {
//   //     // Check if there are friend requests
//   //     if (currentUser.friendRequest.isNotEmpty) {
//   //       // Get the user who sent the invitation
//   //       final String senderId = currentUser.friendRequest.first;

//   //       // Update acceptedFriendRequests for the current user
//   //       currentUser.acceptedFriendRequest.add(senderId);
//   //       await FirebaseFirestore.instance
//   //           .collection('users')
//   //           .doc(currentUser.uid)
//   //           .update({
//   //         'acceptedFriends': FieldValue.arrayUnion([senderId]),
//   //         // 'friendRequests': FieldValue.arrayRemove([senderId]),
//   //       });

//   //       // Update acceptedFriendRequests for the sender
//   //       await FirebaseFirestore.instance
//   //           .collection('users')
//   //           .doc(senderId)
//   //           .update({
//   //         'acceptedFriends': FieldValue.arrayUnion([currentUser.uid]),
//   //       });

//   //       notifyListeners();
//   //     } else {
//   //       print('No friend request to accept.');
//   //     }
//   //   } catch (e) {
//   //     print('Error accepting invitation: $e');
//   //   }
//   // }
// }

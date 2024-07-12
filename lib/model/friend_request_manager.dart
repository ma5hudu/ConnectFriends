// friend_request_manager.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_friends/model/users_.dart';
import 'package:connect_friends/model/friend_request.dart';
import 'package:flutter/material.dart';

class FriendRequestManager extends ChangeNotifier{
  Future<void> sendFriendRequest(Users currentUser, Users selectedUser) async {
    try {
      FriendRequest friendRequest = FriendRequest(
        requesterUid: currentUser.uid,
        requesterName: currentUser.name,
        requesterSurname: currentUser.surname,
        requesterProfilePicture: currentUser.profilePicture,
        receiverUid: selectedUser.uid,
      );
      await FirebaseFirestore.instance
          .collection('friendRequests')
          .add(friendRequest.toJson());

      print('Friend request sent successfully.');

      String notificationMessage =
          '${currentUser.name} sent you a friend request';
      await FirebaseFirestore.instance.collection('notifications').add({
        'userId': selectedUser.uid,
        'message': notificationMessage,
        'timestamp': FieldValue.serverTimestamp(),
      });

    } catch (e) {
      print('Error sending friend request: $e');
    }
  }

   Future<List<Map<String, dynamic>>> getNotificationMessages(
      String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('notifications')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error loading notification messages: $e');
      return []; // Handle the error appropriately
    }
  }

  Future<void> acceptFriendRequest(
      String currentUserId, String requesterId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .update({
        'acceptedFriendRequest': FieldValue.arrayUnion([requesterId]),
        'friendRequest': FieldValue.arrayRemove([requesterId]),
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(requesterId)
          .update({
        'acceptedFriendRequest': FieldValue.arrayUnion([currentUserId]),
      });
    } catch (e) {
      print('Error accepting friend request: $e');
    }
  }
}

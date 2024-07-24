// friend_request_manager.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_friends/model/users_.dart';
import 'package:connect_friends/model/friend_request.dart';
import 'package:flutter/material.dart';

class FriendRequestManager extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendFriendRequest(Users currentUser, Users selectedUser) async {
    try {
      FriendRequest friendRequest = FriendRequest(
        requesterUid: currentUser.uid,
        requesterName: currentUser.name,
        requesterSurname: currentUser.surname,
        requesterProfilePicture: currentUser.profilePicture,
        receiverUid: selectedUser.uid,
      );
      await _firestore.collection('friendRequests').add(friendRequest.toJson());

      print('Friend request sent successfully.');

      String notificationMessage =
          '${currentUser.name} sent you a friend request';
      await _firestore.collection('notifications').add({
        'requesterUid': currentUser.uid,
        'receiverUid': selectedUser.uid,
        'message': notificationMessage,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error sending friend request: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getNotificationMessages(
      String receiverUid) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('notifications')
          .where('receiverUid', isEqualTo: receiverUid)
          .orderBy('timestamp', descending: true)
          .get();

      print('Botification fetched: ${snapshot.docs.length}');
      return snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error loading notification messages: $e');
      return []; // Handle the error appropriately
    }
  }

  Future<bool> isRequestSent(String requesterUid, String receiverUid) async {
    QuerySnapshot requestSnapshot = await _firestore
        .collection('friendRequests')
        .where('requesterUid', isEqualTo: requesterUid)
        .where('receiverUid', isEqualTo: receiverUid)
        .get();

    return requestSnapshot.docs.isNotEmpty;
  }

  Future<void> cancelFriendRequest(
      String requesterUid, String receiverUid) async {
    // Delete friend request document
    QuerySnapshot requestSnapshot = await _firestore
        .collection('friendRequests')
        .where('requesterUid', isEqualTo: requesterUid)
        .where('receiverUid', isEqualTo: receiverUid)
        .get();

    for (DocumentSnapshot doc in requestSnapshot.docs) {
      await _firestore.collection('friendRequests').doc(doc.id).delete();
    }

    // Delete related notifications if the invitation is canceled
    QuerySnapshot notificationSnapshot = await _firestore
        .collection('notifications')
        .where('requesterUid', isEqualTo: requesterUid)
        .where('receiverUid', isEqualTo: receiverUid)
        .get();

    for (DocumentSnapshot doc in notificationSnapshot.docs) {
      await _firestore.collection('notifications').doc(doc.id).delete();
    }
  }

  //fetch friend requests from firebase
  Future<List<FriendRequest>> loadFriendRequest(String receiverUid) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('friendRequests')
          .where('receiverUid', isEqualTo: receiverUid)
          .where('status', isEqualTo: 'pending')
          .get();

      List<FriendRequest> requests = snapshot.docs.map((doc) {
        var data = doc.data();
        return FriendRequest(
          requesterUid: data['requesterUid'],
          requesterName: data['requesterName'],
          requesterSurname: data['requesterSurname'],
          requesterProfilePicture: data['requesterProfilePicture'],
          receiverUid: data['receiverUid'],
          status: data['status'],
        );
      }).toList();
       return requests;

    } catch (error) {
      print('Error fetching friend requests: $error');
      return [];
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
      await _firestore.collection('users').doc(requesterId).update({
        'acceptedFriendRequest': FieldValue.arrayUnion([currentUserId]),
      });
    } catch (e) {
      print('Error accepting friend request: $e');
    }
  }
}

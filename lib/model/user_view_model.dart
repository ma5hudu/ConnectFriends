import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_friends/model/users_.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserViewMode extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Users> _user = [];
  List<Users> get users => _user;

  Future<void> loadUserDetails() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('users').get();
      _user =
          snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
        final data = doc.data();
        return Users(
          uid: doc.id,
          name: data['name'] as String,
          surname: data['surname'] as String,
          email: data['email'] as String,
          profilePicture: data['profilePicture'] as String,
        );
      }).toList();
      notifyListeners();
    } catch (exception) {
      print('Error loading users: $exception');
    }
  }
}

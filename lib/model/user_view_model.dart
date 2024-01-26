import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connect_friends/model/users_.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserViewMode extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Users> _user = [];
  List<Users> get users => _user;

  Users? _currentUser;
  Users? get currentUser => _currentUser;

  Future<void> loadUserDetails() async {
    try {
      final User? firebaseUser = _auth.currentUser;
      if (firebaseUser != null) {
        final DocumentSnapshot<Map<String, dynamic>> snapshot =
            await _firestore.collection('users').doc(firebaseUser.uid).get();

        final data = snapshot.data();
        if (data != null) {
          _user = [
            Users(
              uid: snapshot.id,
              name: data['name'] as String,
              surname: data['surname'] as String,
              email: data['email'] as String,
              profilePicture: data['profilePicture'] as String,
            )
          ];
          _currentUser = _user.first;
        } else {
          // Handle the case where data is null (document not found)
          print('User document not found for UID: ${firebaseUser.uid}');
          _user = [];
          _currentUser = null;
        }

        notifyListeners();
      }
    } catch (exception) {
      print('Error loading users: $exception');
    }
  }





  Future<void> loadRegisterdUser() async {
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



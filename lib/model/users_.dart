import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  final String uid;
  final String name;
  final String surname;
  final String email;
  final String profilePicture;
  // bool emailVerified;

  Users({
    required this.uid,
    required this.name,
    required this.surname,
    required this.email, 
    required this.profilePicture,
    // this.emailVerified = false,

    });

    Map<String, Object?> toJson(){
      return {'uid': uid, 'name': name, 'surname': surname, 'email': email, 'profilePicture': profilePicture};
    }

    @override
      String toString(){
      return 'Users {uid: $uid, name: $name, surname: $surname, email: $email, profilePicture: $profilePicture}';
    }
   // final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> storeUserData() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(toJson());
    } catch (e) {
      print('Error storing user data: $e');
    }

  }


}


import 'package:connect_friends/model/users_.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UserOperations {
  static Future<void> registerUser({
    required String name,
    required String surname,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (password == confirmPassword) {
      try {
        FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
        UserCredential userCredential =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        Users currentUser = Users(
          uid: userCredential.user!.uid,
          name: name,
          surname: surname,
          email: email,
          profilePicture: '', // Set based on your logic
        );

        await currentUser.storeUserData();

        // Registration successful
        print('User registered successfully');
      } catch (e) {
        // Handle registration errors
        print('Error during registration: $e');
      }
    } else {
      // Passwords do not match
      print('Passwords do not match');
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get currently signed-in user
  User? getCurrentUser() => _auth.currentUser;

  // Sign in with email & password
  Future<User?> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print('SignIn Error: ${e.message}');
      return null;
    }
  }

  // Sign up (register) new user
  Future<User?> signUp(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      print('SignUp Error: ${e.message}');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print('User signed out successfully');
    } catch (e) {
      print('SignOut Error: $e');
    }
  }
}

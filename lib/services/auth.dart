import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth;
  Stream<User?> get authStateChanges => auth.authStateChanges();
  AuthService(this.auth);

  Future<String?> signIn({String? email, String? password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email!, password: password!);
      return "SignedIn";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}

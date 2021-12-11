import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser userFromFirebaseUser(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  String getUid() {
    final User user = _auth.currentUser;
    return user.uid;
  }

  String getEmail() {
    final User user = _auth.currentUser;
    return user.email;
  }

  Stream<MyUser> get user => _auth.authStateChanges().map(userFromFirebaseUser);

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      User user = (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;
      MyUser myUser = userFromFirebaseUser(user);
      return myUser;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      User user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find<AuthService>();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // ===============================
  // AUTH STATE
  // ===============================
  Stream<User?> authStateChanges() => auth.authStateChanges();

  // ===============================
  // REGISTER
  // ===============================
  Future<String?> register(
    String email,
    String password,
    String username,
  ) async {
    try {
      final cred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await saveUserToFirestore(
        cred.user!,
        username,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // ===============================
  // LOGIN
  // ===============================
  Future<String?> login(String email, String password) async {
    try {
      final cred = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // pastikan user ada
      await saveUserToFirestore(
        cred.user!,
        cred.user!.displayName ?? "User",
      );

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // ===============================
  // SAVE USER
  // ===============================
  Future<void> saveUserToFirestore(User user, String name) async {
    await firestore.collection("users").doc(user.uid).set({
      "uid": user.uid,
      "email": user.email,
      "name": name,
      "photo": user.photoURL ??
          "https://i.pravatar.cc/150?u=${user.uid}",
      "createdAt": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // ===============================
  // CURRENT USER DATA
  // ===============================
  Future<Map<String, dynamic>?> getCurrentUser() async {
    final uid = auth.currentUser?.uid;
    if (uid == null) return null;

    final doc = await firestore.collection("users").doc(uid).get();
    return doc.data();
  }

  // ===============================
  // LOGOUT
  // ===============================
  Future<void> logout() async {
    await auth.signOut();
  }
}

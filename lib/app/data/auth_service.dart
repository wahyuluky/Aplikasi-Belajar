import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Pantau status login user
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  // Register
  Future<String?> register(String email, String password, String username) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Ambil UID
      String uid = userCredential.user!.uid;

      try {
        await _db.collection("users").doc(uid).set({
          "username": username,
          "email": email,
          "created_at": FieldValue.serverTimestamp(),
        });
        print("✔ Firestore success");
      } catch (err) {
        print("❌ Firestore error: $err");
      }


      return null; // sukses
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // Login
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // sukses
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final doc = await FirebaseFirestore.instance.collection("users").doc(uid).get();
      return doc.data();
    } catch (e) {
      print("Error getUserProfile: $e");
      return null;
    }
  }


  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }
}

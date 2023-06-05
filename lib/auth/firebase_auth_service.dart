import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static const _documentConstants = 'Products';
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static User? get currentuser => _auth.currentUser;
  static Future<User?> loginAdmin(String email, String pass) async {
    final credential =
        await _auth.signInWithEmailAndPassword(email: email, password: pass);

    return credential.user;
  }

  static Future<void> UpdateProductAvailable(
      String productId, String available) {
    return _db
        .collection(_documentConstants)
        .doc(productId)
        .update({'isAvailable': available});
  }

  static Future<void> logoutAdmin() {
    return _auth.signOut();
  }
}

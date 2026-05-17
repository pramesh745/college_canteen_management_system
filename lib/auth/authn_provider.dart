import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthnProvider extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseStorage = FirebaseFirestore.instance;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  Future<bool> registerUser({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
    }
  }

  Future<bool> registerRole({
    required String fullName,
    required String email,
    required String phone,
    required String role,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _firebaseStorage.collection('register_role').add({
        "fullName": fullName,
        "email": email,
        "phone": phone,
        "role": role,
        "isActive": isActive,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      });
      notifyListeners();
      return true;
    } on FirebaseException catch (e) {
      _errorMessage = e.toString();
      print(_errorMessage);
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login({required String email, required String password}) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

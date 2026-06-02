import 'dart:math';

import 'package:college_canteen/core/auth_secure.dart';
import 'package:college_canteen/model/get_users_model.dart';
import 'package:college_canteen/screens/admin/admin_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthnProvider extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firebaseStorage = FirebaseFirestore.instance;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  List<GetUsersModel> userList = [];

  String? fullName;
  String? userEmail;


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
      notifyListeners();
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
      await AuthSecure.saveLoginKey();
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

  Future<List<Object>> getUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      final users = await _firebaseStorage.collection("register_role").get();

      for (var user in users.docs) {
        Map<String, dynamic> data = user.data();

        userList.add(
          GetUsersModel(
            fullName: data["fullName"] ?? "",
            email: data["email"] ?? "",
            phone: data["phone"] ?? "",
            role: data["role"] ?? "",
            isActive: data["isActive"] ?? false,
          ),
        );
      }
      return userList;
    } on FirebaseException catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> getUserRole(String email) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _firebaseStorage
          .collection("register_role")
          .where("email", isEqualTo: email)
          .where("isActive", isEqualTo: true)
          .get();
      if (result.docs.isNotEmpty) {
        return result.docs.first["role"];
      }
    } on FirebaseException catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> loadUserData(String email) async {

    final result = await _firebaseStorage.collection("register_role").where(
        "email", isEqualTo: email).get();
    if(result.docs.isNotEmpty){
      final data = result.docs.first.data();

      fullName = data["fullName"] ?? "";
      userEmail = data["email"] ?? "";
      notifyListeners();
    }
  }


  Future<void>logOut()async{
    await _firebaseAuth.signOut();
  }
}

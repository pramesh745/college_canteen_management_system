import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_canteen/model/get_all_foods_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ManageFoodProvider extends ChangeNotifier {
  final FirebaseFirestore _firebaseStorage = FirebaseFirestore.instance;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  List<GetAllFoodsModel> allFoodsList = [];

  Future<bool> postManageFood({
    required String foodName,
    required String price,
    required String description,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _firebaseStorage.collection("manage_foods").add({
        "foodName": foodName,
        "price": price,
        "description": description,
      });
      notifyListeners();
      return true;
    } on FirebaseException catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> getAllFoods() async {
    _isLoading = true;
    notifyListeners();

    try {
      allFoodsList.clear();
      final allFoods = await _firebaseStorage.collection("manage_foods").get();
      for (var food in allFoods.docs) {
        Map<String, dynamic> foods = food.data();
        allFoodsList.add(
          GetAllFoodsModel(
            foodName: foods["foodName"] ?? "",
            price: foods["price"] ?? "",
            description: foods["description"] ?? "",
          ),
        );
      }
      return true;
    } on FirebaseException catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

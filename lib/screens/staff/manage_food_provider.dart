import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_canteen/model/get_all_foods_model.dart';
import 'package:college_canteen/model/get_my_orders_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ManageFoodProvider extends ChangeNotifier {
  final FirebaseFirestore _firebaseStorage = FirebaseFirestore.instance;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  List<GetAllFoodsModel> allFoodsList = [];

  List<GetMyOrdersModel> myOrdersList = [];

  Future<bool> postManageFood({
    required String foodName,
    required double price,
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

  Future<bool> postOrderFood({
    required String foodName,
    required double quantity,
    required double price,
    required String email,
    required String fullName,
  }) async {
    final now = DateTime.now();
    //
    String orderId = "ORD-${now.millisecondsSinceEpoch}";
    // String date = "${now.day}/${now.month}/${now.year}";
    // String time = "${now.hour}:${now.minute}/${now.timeZoneOffset}";
    _isLoading = true;
    notifyListeners();

    try {
      await _firebaseStorage.collection("order_food").add({
        "fullName": fullName,
        "orderId": orderId,
        "email": email,
        "foodName": foodName,
        "quantity": quantity,
        "price": price,
        "time": DateFormat("hh:mm a").format(now),
        "date": DateFormat("yyyy-MM-dd").format(now),
        "status": "Pending",
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

  Future<List<dynamic>> getMyOrders(String email) async {
    _isLoading = true;
    notifyListeners();

    try {
      final success = await _firebaseStorage.collection("order_food")
        .where("email", isEqualTo: email).get();

      myOrdersList.clear();
      for (var order in success.docs) {
        Map<String, dynamic> orders = order.data();
        myOrdersList.add(
          GetMyOrdersModel(
            orderId: orders["orderId"] ?? "",
            foodName: orders["foodName"] ?? "",
            price: orders["price"] ?? 0,
            quantity: orders["quantity"] ?? 0,
            date: orders["date"] ?? "",
            time: orders["time"] ?? "",
          ),
        );
      }
      print("Orders Found");
      return myOrdersList;
    } on FirebaseException catch (e) {
      _errorMessage = e.toString();
      return [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

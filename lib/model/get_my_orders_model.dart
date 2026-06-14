import 'package:flutter/cupertino.dart';

class GetMyOrdersModel {
  String? orderId;
  String? foodName;
  double? price;
  double? quantity;
  String? date;
  String? time;

  GetMyOrdersModel({
    required this.orderId,
    required this.foodName,
    required this.price,
    required this.quantity,
    required this.date,
    required this.time
  });
}

import 'package:college_canteen/auth/authn_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StaffDashboard extends StatefulWidget {
  const StaffDashboard({super.key});

  @override
  State<StaffDashboard> createState() => _StaffDashboardState();
}

class _StaffDashboardState extends State<StaffDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("Welcome to staff Dashboard"),
        Consumer<AuthnProvider>(builder: (context, loginProvider, child)=>
          IconButton(onPressed: () {
            loginProvider.logOut();
          }, icon: Icon(Icons.logout)),
        )],));
  }
}

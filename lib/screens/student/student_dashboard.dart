import 'package:college_canteen/auth/login_page.dart';
import 'package:college_canteen/auth/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/my_widgets.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: MyWidgets.customAppbar(),

      drawer: MyWidgets.customDrawer(
        context,
        firstTitle: "Dashboard",
        secondTitle: "Profile",
        thirdTitle: "My Orders",
        fourthTitle: "Order History",
        firstIcon: Icons.shopping_bag,
        secondIcon: Icons.person,
        thirdIcon: Icons.shopping_bag,
        fourthIcon: Icons.history,
        firstOnTap: () {},
        secondOnTap: () {},
        thirdOnTap: () {},
        fourthOnTap: () {},
      ),
    );
  }
}

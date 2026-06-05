import 'package:college_canteen/auth/register_role_page.dart';
import 'package:college_canteen/screens/admin/profile_page.dart';
import 'package:college_canteen/screens/widgets/my_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/authn_provider.dart';
import '../../auth/login_page.dart';
import '../../auth/register_page.dart';
import 'admin_dashboard.dart';

class ManageUsers extends StatefulWidget {
  const ManageUsers({super.key});

  @override
  State<ManageUsers> createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: MyWidgets.customAppbar(),
      drawer: MyWidgets.customDrawer(
        context,
        firstIcon: Icons.dashboard,
        secondIcon: Icons.person,
        thirdIcon: Icons.people,
        fourthIcon: Icons.emoji_food_beverage,
        firstTitle: "Dashboard",
        secondTitle: "Profile",
        thirdTitle: "Manage Users",
        fourthTitle: "Manage Food Items",
        firstOnTap: () {
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => AdminDashboardPage()),
            (route) => false,
          );
        },
        secondOnTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProfilePage()),
          );
        },
        thirdOnTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ManageUsers()),
          );
        },
        fourthOnTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ManageUsers()),
          );
        },
      ),
      drawerScrimColor: Colors.grey,

      body: GridView(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.1,
        ),
        children: [
          MyWidgets.dashboardCard(
            icon: Icons.people,
            title: "View Users",
            onTap: () {},
          ),
          MyWidgets.dashboardCard(
            icon: Icons.manage_accounts,
            title: "Add Users",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

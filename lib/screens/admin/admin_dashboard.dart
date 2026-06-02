import 'package:college_canteen/auth/authn_provider.dart';
import 'package:college_canteen/auth/login_page.dart';
import 'package:college_canteen/auth/register_page.dart';
import 'package:college_canteen/screens/admin/manage_users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/my_widgets.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {

  @override
  void initState() {
    // TODO: implement initState
    final userProvider = Provider.of<AuthnProvider>(context,listen: false);
    final email = FirebaseAuth.instance.currentUser?.email??"";
    userProvider.loadUserData(email);
    super.initState();
  }



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
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AdminDashboardPage()));
        },
        secondOnTap: () {},
        thirdOnTap: () {},
        fourthOnTap: () {},
      ),
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
            icon: Icons.manage_accounts,
            title: "Manage Users",
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => ManageUsers()),
                    (route) => false,
              );
            },
          ),
          MyWidgets.dashboardCard(
            icon: Icons.shopping_bag,
            title: "View All Orders",
            onTap: () {},
          ),
          MyWidgets.dashboardCard(
            icon: Icons.fact_check,
            title: "Manage Orders",
            onTap: () {},
          ),
          MyWidgets.dashboardCard(
            icon: Icons.fastfood,
            title: "Manage Food Items",
            onTap: () {},
          ),
          MyWidgets.dashboardCard(
            icon: Icons.receipt_long,
            title: "View Sales Report",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

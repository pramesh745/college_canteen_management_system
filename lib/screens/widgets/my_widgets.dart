import 'package:college_canteen/auth/authn_provider.dart';
import 'package:college_canteen/auth/login_page.dart';
import 'package:college_canteen/screens/admin/admin_dashboard.dart';
import 'package:college_canteen/screens/admin/manage_users.dart';
import 'package:college_canteen/screens/admin/profile_page.dart';
import 'package:college_canteen/screens/student/student_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyWidgets {
  //Created CustomAppBar Widget//
  static AppBar customAppbar() {
    return AppBar(
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.notifications, size: 28)),
      ],
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Welcome,",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          Text(
            " Username",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          ),
        ],
      ),
      centerTitle: true,
      backgroundColor: Color(0xFFF4F6F9),
    );
  }

  //Created CustomDrawer Widget//

  static Drawer customDrawer(
    BuildContext context, {
    required IconData firstIcon,
    required IconData secondIcon,
    required IconData thirdIcon,
    required IconData fourthIcon,
    required String firstTitle,
    required String secondTitle,
    required String thirdTitle,
    required String fourthTitle,
    required VoidCallback firstOnTap,
    required VoidCallback secondOnTap,
    required VoidCallback thirdOnTap,
    required VoidCallback fourthOnTap,
  }) {
    return Drawer(
      backgroundColor: const Color(0xFFF4F6F9),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Consumer<AuthnProvider>(
        builder: (context, userProvider, child) => Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 60,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 40, color: Colors.orange),
                  ),

                  SizedBox(height: 15),

                  Text(
                    userProvider.fullName ?? "",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    userProvider.userEmail ?? "",
                    style: TextStyle(fontSize: 15, color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  _drawerTile(
                    icon: firstIcon,
                    title: firstTitle,
                    onTap: firstOnTap,
                  ),

                  _drawerTile(
                    icon: secondIcon,
                    title: secondTitle,
                    onTap: secondOnTap,
                  ),

                  _drawerTile(
                    icon: thirdIcon,
                    title: thirdTitle,
                    onTap: thirdOnTap,
                  ),

                  _drawerTile(
                    icon: fourthIcon,
                    title: fourthTitle,
                    onTap: fourthOnTap,
                  ),
                ],
              ),
            ),

            const Divider(),

            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 25),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                tileColor: Colors.red.shade50,
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  "Logout",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginPage()),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Created DrawerTile Widget for Drawer ListView//

  static Widget _drawerTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Icon(icon, color: Colors.orange),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  //Created DashboardCard Widget//

  static Widget dashboardCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.orange.withOpacity(0.18),
        highlightColor: Colors.orange.withOpacity(0.10),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, Colors.orange.withOpacity(0.02)],
            ),
            border: Border.all(color: Colors.orange.withOpacity(0.08)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 42, color: Colors.orange.shade700),
              ),
              const SizedBox(height: 14),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

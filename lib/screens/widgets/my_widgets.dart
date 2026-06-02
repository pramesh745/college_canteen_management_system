import 'package:college_canteen/screens/student/student_dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      child: Column(
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
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.orange),
                ),

                SizedBox(height: 15),

                Text(
                  "Pramesh Dahal",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  "dahalpramesh7@gmail.com",
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
              onTap: () {},
            ),
          ),
        ],
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
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 55, color: Colors.orange),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

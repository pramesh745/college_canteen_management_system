import 'package:college_canteen/auth/authn_provider.dart';
import 'package:college_canteen/auth/login_page.dart';
import 'package:college_canteen/screens/admin/admin_dashboard.dart';
import 'package:college_canteen/screens/admin/manage_users.dart';
import 'package:college_canteen/screens/admin/profile_page.dart';
import 'package:college_canteen/screens/staff/manage_food_provider.dart';
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
      title: Text(
        "College Canteen",
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
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
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
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
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Colors.white,
            border: Border.all(color: Colors.orange.withOpacity(0.08)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon container (clean elevated look)
              Container(
                height: 58,
                width: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange.withOpacity(0.18),
                      Colors.orange.withOpacity(0.06),
                    ],
                  ),
                ),
                child: Icon(icon, size: 28, color: Colors.orange.shade700),
              ),

              const SizedBox(height: 12),

              // Title
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 10),

              // subtle action hint
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Tap to open",
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Colors.orange.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Widget for popup action when clicked on dashboard items//

  static Future<bool?> showAddFoodDialog(BuildContext context) {
    final foodNameController = TextEditingController();
    final foodPriceController = TextEditingController();
    final foodDescriptionController = TextEditingController();

    return showDialog<bool?>(
      context: context,
      builder: (context) => Consumer<ManageFoodProvider>(
        builder: (context, manageFoodProvider, child) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text("Add Food Item"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.add_a_photo, size: 30),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: foodNameController,
                  decoration: InputDecoration(
                    labelText: "Food Name",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),
                TextField(
                  controller: foodPriceController,
                  decoration: InputDecoration(
                    labelText: "Price",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),
                TextField(
                  controller: foodDescriptionController,
                  decoration: InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: manageFoodProvider.isLoading
                  ? null
                  : () async {
                      final success = await manageFoodProvider.postManageFood(
                        foodName: foodNameController.text.trim(),
                        price: double.parse(foodPriceController.text.trim()),
                        description: foodDescriptionController.text.trim(),
                      );
                      if (success && context.mounted) {
                        Navigator.pop(context, true);
                      }
                    },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  static Future<bool?> showOrderFoodDialog(
    BuildContext context, {
    required String foodName,
    required double price,
  }) {
    final foodNameController = TextEditingController(text: foodName);
    final totalPriceController = TextEditingController(text: price.toString());
    final foodQuantityController = TextEditingController();
    final email = FirebaseAuth.instance.currentUser?.email ?? "";


    return showDialog<bool?>(
      context: context,
      builder: (context) => Consumer<ManageFoodProvider>(
        builder: (context, manageFoodProvider, child) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text("Place an order"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 40,
                    child: Icon(Icons.add_a_photo, size: 30),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  readOnly: true,
                  controller: foodNameController,
                  decoration: const InputDecoration(
                    labelText: "Food Name",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 12),
                TextField(
                  controller: foodQuantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Quantity",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    final quantity = double.tryParse(value) ?? 0;
                    totalPriceController.text = (price * quantity)
                        .toStringAsFixed(2);
                  },
                ),

                const SizedBox(height: 12),
                TextField(
                  controller: totalPriceController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Total Price",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: manageFoodProvider.isLoading
                  ? null
                  : () async {
                      final success = await manageFoodProvider.postOrderFood(
                        foodName: foodNameController.text.trim(),
                        quantity: double.parse(
                          foodQuantityController.text.trim(),
                        ),
                        price:
                            double.tryParse(totalPriceController.text.trim()) ??
                            0.0, email: email,
                      );

                      if (success && context.mounted) {
                        Navigator.pop(context, true);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("$foodName Successfully ordered"),
                          ),
                        );
                      }
                    },
              child: const Text("Order"),
            ),
          ],
        ),
      ),
    );
  }
}

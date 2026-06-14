import 'package:college_canteen/auth/authn_provider.dart';
import 'package:college_canteen/screens/staff/available_foods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/my_widgets.dart';
import '../admin/profile_page.dart';


class StaffDashboard extends StatefulWidget {
  const StaffDashboard({super.key});

  @override
  State<StaffDashboard> createState() => _StaffDashboardState();
}

class _StaffDashboardState extends State<StaffDashboard> {
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
        },
        secondOnTap: () {},
        thirdOnTap: () {},
        fourthOnTap: () {},
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
            icon: Icons.receipt_long,
            title: "Live Orders",
            onTap: () {},
          ),
          MyWidgets.dashboardCard(
            icon: Icons.pending_actions,
            title: "Pending Orders",
            onTap: () {},
          ),
          MyWidgets.dashboardCard(
            icon: Icons.restaurant,
            title: "Preparing Orders",
            onTap: () {},
          ),
          MyWidgets.dashboardCard(
            icon: Icons.notifications_active,
            title: "Ready for Pickup",
            onTap: () {},
          ),
          MyWidgets.dashboardCard(
            icon: Icons.check_circle,
            title: "Completed Orders",
            onTap: () {},
          ),
          MyWidgets.dashboardCard(
            icon: Icons.fastfood,
            title: "Add Food",
            onTap: () async {
              final success = await MyWidgets.showAddFoodDialog(context);
              if (success == true && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Food Item added successfully")),
                );
              }
            },
          ),

          MyWidgets.dashboardCard(
            icon: Icons.food_bank,
            title: "Available Foods",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AvailableFoods()),
              );
            },
          ),

          MyWidgets.dashboardCard(
            icon: Icons.trending_up,
            title: "Popular Food Items",
            onTap: () {},
          ),
          MyWidgets.dashboardCard(
            icon: Icons.attach_money,
            title: "Today's Sales",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

import 'package:college_canteen/screens/student/student_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/my_widgets.dart';
import '../staff/manage_food_provider.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final email = FirebaseAuth.instance.currentUser?.email ?? "";
      Provider.of<ManageFoodProvider>(
        context,
        listen: false,
      ).getMyOrders(email);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF4F6F9),
      appBar: MyWidgets.customAppbar(),

      // Your drawer here
      drawer: MyWidgets.customDrawer(
        context,
        firstIcon: Icons.dashboard,
        secondIcon: Icons.person,
        thirdIcon: Icons.shopping_cart,
        fourthIcon: Icons.receipt_long,
        firstTitle: "Dashboard",
        secondTitle: "Profile",
        thirdTitle: "Cart",
        fourthTitle: "My Orders",
        firstOnTap: () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => StudentDashboard()),
          (route) => false,
        ),
        secondOnTap: () {},
        thirdOnTap: () {},
        fourthOnTap: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.orange,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Orders",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Check order status and view your order history anytime",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search food...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: Consumer<ManageFoodProvider>(
                builder: (context, manageFoodProvider, child) {
                  if (manageFoodProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (manageFoodProvider.myOrdersList.isEmpty) {
                    return const Center(child: Text("No orders available"));
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      final email =
                          FirebaseAuth.instance.currentUser?.email ?? "";

                      await Provider.of<ManageFoodProvider>(
                        context,
                        listen: false,
                      ).getMyOrders(email);
                    },
                    child: ListView.builder(
                      itemCount: manageFoodProvider.myOrdersList.length,
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 20,
                      ),
                      itemBuilder: (context, index) {
                        final orders = manageFoodProvider.myOrdersList[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Top row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    orders.orderId ?? "",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Preparing",
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),

                              // Food name (from provider)
                              Text(
                                "${orders.foodName ?? ""} / ${orders.quantity}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),

                              const SizedBox(height: 8),

                              // Price + Date
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total: Rs. ${orders.price}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  Text(
                                    "${orders.date} • ${orders.time}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

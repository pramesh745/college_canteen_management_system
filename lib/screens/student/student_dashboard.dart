import 'package:college_canteen/screens/staff/manage_food_provider.dart';
import 'package:college_canteen/screens/student/my_orders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/my_widgets.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ManageFoodProvider>(context, listen: false).getAllFoods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        firstOnTap: () => Navigator.pop(context),
        secondOnTap: () {},
        thirdOnTap: () {},
        fourthOnTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => MyOrders()),
          );
        },
      ),

      body: Column(
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
                  "What would you like to eat today?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Order your favorite meals quickly.",
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

          const SizedBox(height: 16),

          Expanded(
            child: Consumer<ManageFoodProvider>(
              builder: (context, manageFoodProvider, child) {
                if (manageFoodProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (manageFoodProvider.allFoodsList.isEmpty) {
                  return const Center(child: Text("No food items available"));
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await manageFoodProvider.getAllFoods();
                  },
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: manageFoodProvider.allFoodsList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.55, // was 0.85
                        ),
                    itemBuilder: (context, index) {
                      final food = manageFoodProvider.allFoodsList[index];

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.orange.withOpacity(
                                  0.15,
                                ),
                                child: Icon(
                                  Icons.eighteen_mp,
                                  size: 35,
                                  color: Colors.orange,
                                ),
                              ),

                              const SizedBox(height: 12),

                              Text(
                                food.foodName.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                "Rs. ${food.price}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                "${food.description}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),

                              const SizedBox(height: 18),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    MyWidgets.showOrderFoodDialog(
                                      context,
                                      foodName: food.foodName ?? "",
                                      price:
                                          double.tryParse(food.price ?? "0") ??
                                          0.0,
                                    );
                                  },
                                  icon: const Icon(Icons.shopping_bag),
                                  label: const Text("Order"),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    // Add order logic
                                  },
                                  icon: const Icon(Icons.shopping_cart),
                                  label: const Text("Add to Cart"),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/my_widgets.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  final List<Map<String, dynamic>> foodItems = [
    {
      "name": "Chicken Mo:Mo",
      "price": 180,
      "icon": Icons.ramen_dining,
    },
    {
      "name": "Burger",
      "price": 150,
      "icon": Icons.lunch_dining,
    },
    {
      "name": "Chowmein",
      "price": 120,
      "icon": Icons.restaurant,
    },
    {
      "name": "Pizza",
      "price": 250,
      "icon": Icons.local_pizza,
    },
    {
      "name": "Cold Drink",
      "price": 50,
      "icon": Icons.local_drink,
    },
    {
      "name": "French Fries",
      "price": 100,
      "icon": Icons.fastfood,
    },
  ];

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
        fourthOnTap: () {},
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
                  style: TextStyle(
                    color: Colors.white70,
                  ),
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
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: foodItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.65, // was 0.85
              ),
              itemBuilder: (context, index) {
                final food = foodItems[index];

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
                          backgroundColor: Colors.orange.withOpacity(0.15),
                          child: Icon(
                            food["icon"],
                            size: 35,
                            color: Colors.orange,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          food["name"],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "Rs. ${food["price"]}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),


                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Add order logic
                            },
                            icon: const Icon(Icons.shopping_cart),
                            label: const Text("Order"),
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
          ),
        ],
      ),
    );
  }
}
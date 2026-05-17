import 'package:flutter/material.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {

  final List<Map<String, dynamic>> dashboardItems = [
    {
      "title": "Total Orders",
      "count": "128",
      "icon": Icons.shopping_cart,
    },
    {
      "title": "Food Items",
      "count": "42",
      "icon": Icons.fastfood,
    },
    {
      "title": "Students",
      "count": "350",
      "icon": Icons.people,
    },
    {
      "title": "Revenue",
      "count": "Rs. 25,000",
      "icon": Icons.attach_money,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),

      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: const Text(
          "Admin Dashboard",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.orange,
              ),
              accountName: const Text("Admin"),
              accountEmail: const Text("admin@canteen.com"),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.admin_panel_settings,
                  size: 40,
                  color: Colors.orange,
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.fastfood),
              title: const Text("Manage Foods"),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text("Orders"),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.people),
              title: const Text("Users"),
              onTap: () {},
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {},
            ),

            const Spacer(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // Welcome Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Admin 👋",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    "Manage your college canteen system easily.",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Dashboard Grid
            Expanded(
              child: GridView.builder(
                itemCount: dashboardItems.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) {

                  final item = dashboardItems[index];

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        CircleAvatar(
                          radius: 28,
                          backgroundColor:
                          Colors.orange.withOpacity(0.15),
                          child: Icon(
                            item["icon"],
                            size: 30,
                            color: Colors.orange,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Text(
                          item["count"],
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          item["title"],
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
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
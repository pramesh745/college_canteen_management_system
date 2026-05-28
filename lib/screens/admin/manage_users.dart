import 'package:college_canteen/auth/register_role_page.dart';
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
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications, size: 28),
          ),
        ],
        title: Text(
          "Admin Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      drawer: Drawer(
        child: Consumer<AuthnProvider>(
          builder: (context, loginProvider, child) => Column(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                child: DrawerHeader(
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(color: Colors.orange),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(radius: 30, backgroundColor: Colors.white),
                      SizedBox(height: 15),
                      Text("Pramesh Dahal", style: TextStyle(fontSize: 24)),
                      Text(
                        "dahalpramesh32435@gmail.com",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(height: 10),
                    ListTile(
                      leading: Icon(Icons.dashboard, size: 28),
                      title: Text("Dashboard", style: TextStyle(fontSize: 18)),
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AdminDashboardPage(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.person, size: 28),
                      title: Text("Profile", style: TextStyle(fontSize: 18)),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.people, size: 28),
                      title: Text(
                        "Manage Users",
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => ManageUsers()),
                          (route) => false,
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.fastfood, size: 28),
                      title: Text(
                        "Manage Food Items",
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                contentPadding: EdgeInsets.only(bottom: 24, left: 12),
                leading: Icon(
                  Icons.exit_to_app,
                  size: 28,
                  color: Colors.deepOrangeAccent,
                ),
                title: Text(
                  "Logout",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("You've been logged out")),
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
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
          manageUserCard(
            icon: Icons.people_alt,
            title: "View Users",
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => RegisterRolePage()),
                (route) => false,
              );
            },
          ),
          manageUserCard(
            icon: Icons.manage_accounts,
            title: "Add User",
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => RegisterPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget manageUserCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.orange),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:college_canteen/auth/authn_provider.dart';
import 'package:college_canteen/auth/register_page.dart';
import 'package:college_canteen/screens/admin/admin_dashboard.dart';
import 'package:college_canteen/screens/admin/profile_page.dart';
import 'package:college_canteen/screens/widgets/my_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/admin/manage_users.dart';
import 'login_page.dart';

class RegisterRolePage extends StatefulWidget {
  const RegisterRolePage({super.key});

  @override
  State<RegisterRolePage> createState() => _RegisterRolePageState();
}

class _RegisterRolePageState extends State<RegisterRolePage> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String selectedRole = "Student";
  bool isActive = true;

  final List<String> roles = ["Student", "Staff", "Admin"];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => ProfilePage()),(route)=> false
          );
        },
        secondOnTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProfilePage()),
          );
        },
        thirdOnTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProfilePage()),
          );
        },
        fourthOnTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProfilePage()),
          );
        },
      ),
      drawerScrimColor: Colors.grey,
      body: registerRoleContainer(),
    );
  }

  Widget registerRoleContainer() {
    final size = MediaQuery.of(context).size;

    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: size.width * 0.88,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              const Icon(Icons.person_add, size: 60, color: Colors.orange),

              const SizedBox(height: 15),

              const Text(
                "User Registration",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 25),

              // Full Name
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Phone
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Role Dropdown
              DropdownButtonFormField(
                value: selectedRole,
                items: roles.map((role) {
                  return DropdownMenuItem(value: role, child: Text(role));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRole = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Role",
                  prefixIcon: const Icon(Icons.badge),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Active Switch
              SwitchListTile(
                value: isActive,
                activeColor: Colors.orange,
                title: const Text("Active User"),
                onChanged: (value) {
                  setState(() {
                    isActive = value;
                  });
                },
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: Consumer<AuthnProvider>(
                  builder: (context, roleRegistration, child) =>
                      roleRegistration.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () async {
                            final success = await roleRegistration.registerRole(
                              fullName: _fullNameController.text.trim(),
                              email: _emailController.text.trim(),
                              phone: _phoneController.text.trim(),
                              role: selectedRole,
                              isActive: isActive,
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            );
                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Successfully Registered"),
                                ),
                              );
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AdminDashboardPage(),
                                ),
                                (route) => false,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Failed to register")),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Register User",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

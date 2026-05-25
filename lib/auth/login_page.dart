import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_canteen/auth/authn_provider.dart';
import 'package:college_canteen/auth/register_page.dart';
import 'package:college_canteen/core/auth_secure.dart';
import 'package:college_canteen/screens/admin/admin_dashboard.dart';
import 'package:college_canteen/screens/staff/staff_dashboard.dart';
import 'package:college_canteen/screens/student/student_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    checkLoggedIn();
    super.initState();
  }
  
  void checkLoggedIn()async {
    final loginProvider = Provider.of<AuthnProvider>(context, listen: false);

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final email = user.email ?? "";
      await loginProvider.loadUserData(email);
      String? role = await loginProvider.getUserRole(email);
      if (!mounted) return;

      if (role == "Admin") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => AdminDashboardPage(),
          ),
              (route) => false,
        );
      } else if (role == "Staff") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => StaffDashboard(),
          ),
              (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => StudentDashboard(),
          ),
              (route) => false,
        );
      }
    }

  }
  
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: size.width * 0.85,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.restaurant_menu,
                  size: 60,
                  color: Colors.orange,
                ),

                const SizedBox(height: 10),

                const Text(
                  "Canteen Login",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 25),

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

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Consumer<AuthnProvider>(
                    builder: (context, loginProvider, child) =>
                        loginProvider.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () async {
                              final success = await loginProvider.login(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                              if (success) {
                                await loginProvider.loadUserData(
                                  _emailController.text.trim(),
                                );

                                String? role = await loginProvider.getUserRole(
                                  _emailController.text.trim(),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Successfully Logged In"),
                                  ),
                                );
                                if (role == "Admin") {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => AdminDashboardPage(),
                                    ),
                                    (route) => false,
                                  );
                                } else if (role == "Staff") {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => StaffDashboard(),
                                    ),
                                    (route) => false,
                                  );
                                } else {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => StudentDashboard(),
                                    ),
                                    (route) => false,
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Failed to Login")),
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
                              "Login",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    Text((" Contact Admin")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

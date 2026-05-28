import 'package:college_canteen/auth/authn_provider.dart';
import 'package:college_canteen/auth/login_page.dart';
import 'package:college_canteen/auth/register_role_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/admin/admin_dashboard.dart';
import '../screens/admin/manage_users.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                          MaterialPageRoute(
                            builder: (_) => ManageUsers(),
                          ),
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
      body: registerContainer(context),
    );
  }
  Widget registerContainer(BuildContext context){

    final size = MediaQuery.of(context).size;
    return Center(
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
                Icons.person_add_alt_1,
                size: 60,
                color: Colors.orange,
              ),

              const SizedBox(height: 10),

              const Text(
                "Create Account",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 5),

              const Text(
                "College Canteen Management System",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey),
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
                  builder: (context, registerProvider, child) =>
                  registerProvider.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                    onPressed: () async {
                      final success = await registerProvider
                          .registerUser(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "User registered Successfully",
                            ),
                          ),
                        );
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RegisterRolePage(),
                          ),
                              (route) => false,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Failed to Register user"),
                          ),
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
                      "Register",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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



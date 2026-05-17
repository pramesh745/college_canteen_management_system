import 'package:college_canteen/auth/authn_provider.dart';
import 'package:college_canteen/auth/login_page.dart';
import 'package:college_canteen/auth/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [ChangeNotifierProvider(create: (_)=>AuthnProvider())],
      child: MaterialApp(debugShowCheckedModeBanner: false,
        home: const RegisterPage(),
      ),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newapp_test/HomePage.dart';
import 'package:newapp_test/LoginPage.dart';
import 'package:newapp_test/SplashScreen.dart';
import 'package:newapp_test/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VaccineSheba',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If the connection is waiting, show the splash screen
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }

        // If a user is logged in, go to HomePage
        if (snapshot.hasData) {
          return const HomePage();
        }

        // Otherwise, show the LoginPage
        return const LoginPage();
      },
    );
  }
}

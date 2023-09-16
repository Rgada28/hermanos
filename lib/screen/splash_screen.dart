import 'package:flutter/material.dart';
import 'package:hermanos/screen/home_screen.dart';
import 'package:hermanos/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;

  Future<bool> checkAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('user');
    print(user);
    await Future.delayed(Duration(seconds: 2)); // Simulate a delay.
    return isLoggedIn; // Replace with your actual authentication logic.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future:
              checkAuthentication(), // Implement your authentication check here.
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While waiting, you can show a loading indicator.
              return const FlutterLogo(
                size: 2,
              );
            } else if (snapshot.hasError) {
              // Handle any errors during authentication check.
              return Text('Error: ${snapshot.error}');
            } else {
              // If user is authenticated, navigate to HomeScreen. Otherwise, go to LoginScreen.
              return isLoggedIn
                  ? const HomeScreen(
                      title: 'Home',
                    )
                  : const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}

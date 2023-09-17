import 'package:flutter/material.dart';
import 'package:hermanos/screen/home_screen.dart';
import 'package:hermanos/screen/login_screen.dart';
import 'package:hermanos/utils/user_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;

  Future<bool> checkAuthentication() async {
    isLoggedIn = await SharePreferenceHelper.getuserLoginStatus();
    return isLoggedIn;
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

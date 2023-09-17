import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hermanos/screen/home_screen.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';
import '../utils/user_storage.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _usernameController = TextEditingController(text: "mor_2314");
  final _passwordController = TextEditingController(text: "83r5^_");
  bool isAuthenticating = false;

  login() async {
    setState(() {
      isAuthenticating = true;
    });
    final loginurl = Uri.parse('https://fakestoreapi.com/auth/login');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'username': _usernameController.text,
      'password': _passwordController.text
    });
    final response = await http.post(loginurl, headers: headers, body: body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> token = json.decode(response.body);
      final getUser = Uri.parse('https://fakestoreapi.com/users/1');
      final userResponse = await http.get(getUser);
      if (userResponse.statusCode == 200) {
        final Map<String, dynamic> responseData =
            json.decode(userResponse.body);
        User user = User.fromMap(responseData);
        _saveUser(user, token["token"]);
        setState(() {
          isAuthenticating = false;
        });
      }
    } else {
      setState(() {
        isAuthenticating = false;
      });
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Login Failed"),
              content: const Text("Please enter Valid Credentials"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text("Okay"))
              ],
            );
          });
      return;
    }
  }

  _saveUser(User user, String token) async {
    SharePreferenceHelper.storeUserToken(user.toString());
    SharePreferenceHelper.setuserLoginStatus(true);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) {
      return const HomeScreen();
    }));
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _usernameController,
                      maxLength: 50,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        label: Text("Username"),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextField(
                      controller: _passwordController,
                      maxLength: 50,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        label: Text("Password"),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        login();
                      },
                      child: const Text("Save Expense"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: isAuthenticating,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(180, 253, 247, 247)),
              child: const Center(
                  child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator())),
            ),
          )
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';
import '../utils/user_storage.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  login() async {
    final url = Uri.parse('https://fakestoreapi.com/auth/login');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'username': _usernameController.text,
      'password': _passwordController.text
    });
    final response = await http.post(url, headers: headers, body: body);
    print(json.decode(response.body));

    if (response.statusCode == 200) {
      // Successful login
      // final Map<String, dynamic> responseData = json.decode(response.body);

      // User user = User.fromMap(responseData);
      // _saveUser(user);
    } else {
      // Failed login
      throw Exception('Failed to log in');
    }
  }

  _saveUser(User user) async {
    SharePreferenceHelper.storeUserToken(user.toString());
    //TODO Save to RiverPodState as Well
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
      body: Center(
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
              onPressed: login,
              child: const Text("Save Expense"),
            ),
          ],
        ),
      ),
    );
  }
}

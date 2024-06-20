import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Para manejar JSON
import '../components/custom_text_field.dart';
import '../components/custom_button.dart';
import '../main.dart';
import './singUp.dart'; // Asegúrate de que el nombre del archivo coincida

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? usersJson = prefs.getString('users');
      if (usersJson != null) {
        List<Map<String, String>> users = List<Map<String, dynamic>>.from(json.decode(usersJson)).map((user) => Map<String, String>.from(user)).toList();

        bool isAuthenticated = users.any((user) =>
            user['email'] == _emailController.text && user['password'] == _passwordController.text);

        if (isAuthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Flutter Demo Home Page')),
          );
        } else {
          _showErrorDialog('Login Failed', 'Incorrect email or password');
        }
      } else {
        _showErrorDialog('Login Failed', 'No registered users');
      }
    }
  }

  void _showErrorDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomTextField(
                controller: _emailController,
                labelText: 'Enter your email',
                type: TextFieldType.email,
              ),
              CustomTextField(
                controller: _passwordController,
                labelText: 'Enter your password',
                type: TextFieldType.password,
              ),
              CustomButton(
                buttonText: 'Login',
                onPressed: _submitForm,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                child: const Text('Don\'t have an account? Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Para manejar JSON
import '../components/custom_text_field.dart';
import '../components/custom_button.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? usersJson = prefs.getString('users');
      List<Map<String, String>> users = usersJson != null
          ? List<Map<String, dynamic>>.from(json.decode(usersJson)).map((user) => Map<String, String>.from(user)).toList()
          : [];

      // Añadir nuevo usuario
      users.add({
        'email': _emailController.text,
        'password': _passwordController.text,
      });

      // Guardar la lista actualizada de usuarios
      await prefs.setString('users', json.encode(users));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
                buttonText: 'Sign Up',
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

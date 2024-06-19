import 'package:flutter/material.dart';
import '../components/custom_text_field.dart';
import '../components/custom_button.dart';
import '../components/listView.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Entered Text'),
            content: Text('Entered email: ${_emailController.text}\nEntered text: ${_textController.text}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
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
                      controller: _textController,
                      labelText: 'Enter your text',
                      type: TextFieldType.text,
                    ),
                    CustomButton(
                      buttonText: 'Submit',
                      onPressed: _submitForm,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListViews(),
          ),
        ],
      ),
    );
  }
}
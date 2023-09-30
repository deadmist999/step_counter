import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';
import 'package:step_counter/screens/auth_screen/components/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _validateEmail(String? email) {
    if (email != null && EmailValidator.validate(email)) {
      return null;
    } else {
      return 'Please enter a valid email address';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _emailController,
                  textInputType: TextInputType.emailAddress,
                  isObscureText: false,
                  labelText: 'Email',
                  hintText: 'Enter your email address',
                  validator: (email) => _validateEmail(email),
                ),
                CustomTextFormField(
                  controller: _passwordController,
                  textInputType: TextInputType.visiblePassword,
                  isObscureText: true,
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  validator: (password) => null,
                ),
              ],
            ),
          ),
          FilledButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {}
            },
            child: const Text(
              'Login',
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}

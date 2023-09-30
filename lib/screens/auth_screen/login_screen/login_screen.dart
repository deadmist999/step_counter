import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:step_counter/blocs/auth_bloc/auth_bloc.dart';
import 'package:step_counter/screens/auth_screen/components/custom_text_form_field.dart';
import 'package:step_counter/screens/auth_screen/register_screen/register_screen.dart';
import 'package:step_counter/screens/components/loading_indicator.dart';

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
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthorizedUserState) {
                Fluttertoast.showToast(
                  msg: 'Successful',
                  backgroundColor: Colors.green,
                );
              } else if (state is AuthErrorState) {
                _passwordController.clear();
                Fluttertoast.showToast(
                  msg: 'Failure',
                  backgroundColor: Colors.red,
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoadingState) {
                return const LoadingIndicator();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              SignInByEmailAndPasswordEvent(
                                _emailController.text,
                                _passwordController.text,
                              ),
                            );
                      }
                    },
                    child: const Text('Sign In'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RegisterScreen(),
                      ),
                    ),
                    child: const Text('Sign Up'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

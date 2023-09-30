import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:step_counter/blocs/auth_bloc/auth_bloc.dart';
import 'package:step_counter/screens/auth_screen/components/custom_text_form_field.dart';
import 'package:step_counter/screens/components/app_dimensions.dart';
import 'package:step_counter/screens/components/loading_indicator.dart';
import 'package:step_counter/screens/home_screen/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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

  String? _validatePassword(String? password) {
    if (password != null && password.length >= 6) {
      return null;
    } else {
      return 'Please enter a password that contains more than 6 characters';
    }
  }

  void _navigateToHomeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight * 3,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    validator: (email) => _validateEmail(email),
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                    labelText: 'Email',
                    hintText: 'Enter your email address',
                    isObscureText: false,
                  ),
                  CustomTextFormField(
                    validator: (password) => _validatePassword(password),
                    controller: _passwordController,
                    textInputType: TextInputType.visiblePassword,
                    labelText: 'Password',
                    hintText:
                        'Enter a password that contains more than 6 characters',
                    isObscureText: true,
                  ),
                ],
              ),
            ),
            Container(
              padding: AppDimensions.horizontalPadding16,
              width: double.infinity,
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (contest, state) {
                  if (state is AuthorizedUserState) {
                    _navigateToHomeScreen();
                    Fluttertoast.showToast(
                        msg: 'Successful', backgroundColor: Colors.green);
                  } else if (state is AuthErrorState) {
                    Fluttertoast.showToast(
                        msg: state.message, backgroundColor: Colors.red);
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return const LoadingIndicator();
                  }
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              SignUpByEmailAndPasswordEvent(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                      }
                    },
                    child: const Text(
                      'Sign Up',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:stock_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:stock_app/provider/theme_provider.dart';
import 'package:stock_app/screens/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _globalKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Center(
          child: Form(
            key: _globalKey,
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              height: 550,
              decoration: BoxDecoration(
                color: provider.isDarkMode ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: navigateToLoginScreen,
                        icon: const Icon(Icons.arrow_back, size: 30),
                      ),
                      const Text(
                        'Signup',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: const Text('First Name'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: const Text('Last Name'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => validateEmail(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: const Text('Email'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => validatePassword(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: const Text('Password'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: cPasswordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => validateCPassword(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: const Text('Confirm-Password'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthError) {
                        return showSnackBar(
                            message: state.message, color: Colors.red);
                      } else if (state is AuthUserCreated) {
                        navigateToLoginScreen();
                        showSnackBar(
                            message: 'User created! Please Login',
                            color: Colors.green);
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ElevatedButton(
                        onPressed: signupPressed,
                        child: const Text('Singup'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signupPressed() async {
    if (_globalKey.currentState?.validate() == true) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final bloc = context.read<AuthBloc>();
      final event = AuthSignup(email: email, password: password);
      bloc.add(event);
    }
  }

  void navigateToLoginScreen() {
    final route = MaterialPageRoute(builder: (context) => const LoginScreen());
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  void showSnackBar({required String message, required Color color}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String? validateEmail() {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      return 'Please enter email';
    } else if (EmailValidator.validate(email) == false) {
      return 'Please enter correct email';
    }
    return null;
  }

  String? validatePassword() {
    final password = passwordController.text.trim();
    if (password.isEmpty) {
      return 'Please enter password';
    } else if (password.length < 6) {
      return 'Password should be atleast 6 character';
    }
    return null;
  }

  String? validateCPassword() {
    final cPassword = cPasswordController.text.trim();
    final password = passwordController.text.trim();
    if (cPassword != password) {
      return 'Password should be match';
    }
    return null;
  }
}

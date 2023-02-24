import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:stock_app/screens/dashboard.dart';
import 'package:stock_app/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _globalKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: Center(
          child: Container(
            height: 350,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Form(
              key: _globalKey,
              child: ListView(
                children: [
                  const Text('Login',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => validateEmail(),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: const Text('Email'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => validatePassword(),
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.security),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: isObscure ? Colors.blue : Colors.red,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      label: const Text('Password'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthError) {
                        return showSnackBar(
                            message: state.message, color: Colors.red);
                      } else if (state is AuthSuccess) {
                        return navigateToHomePage();
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Column(
                        children: [
                          ElevatedButton(
                            onPressed: loginPressed,
                            child: const Center(child: Text('Login')),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have account !",
                              ),
                              TextButton(
                                onPressed: navigateToSignupScreen,
                                child: const Text('Signup'),
                              )
                            ],
                          ),
                        ],
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

  void loginPressed() async {
    if (_globalKey.currentState?.validate() == true) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final bloc = context.read<AuthBloc>();
      final event = AuthLogin(email: email, password: password);
      bloc.add(event);
    }
  }

  void navigateToHomePage() {
    final route = MaterialPageRoute(builder: ((context) => const Dashboard()));
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  void navigateToSignupScreen() {
    final route = MaterialPageRoute(builder: (context) => const SignupScreen());
    Navigator.push(context, route);
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
}

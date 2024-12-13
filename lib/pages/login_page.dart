import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nibm_unity/constants/colors.dart';
import 'package:nibm_unity/widgets/gradient_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isStudentSelected = true;

  void _alertBox(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Support"),
          content: Text(message),
          actions: [
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
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: FloatingActionButton(
          onPressed: () {
            _alertBox(
                "Enter your LMS email and password to Log in, \nThank you");
          },
          backgroundColor: kWhiteColor,
          child: const Icon(
            Icons.question_mark_rounded,
            color: kMainColor,
          ),
        ),
      ),
      body: GradientContainer(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      constraints: const BoxConstraints(maxWidth: 500),
                      decoration: BoxDecoration(
                        color: kWhiteColor.withAlpha(15),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Navigation Bar Inside Container
                            SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16.0, top: 16.0, right: 16.0),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        context.go('/home');
                                      },
                                      icon: const Icon(Icons.arrow_back,
                                          color: kWhiteColor),
                                    ),
                                    const Text(
                                      "Back to Home",
                                      style: TextStyle(
                                          color: kWhiteColor, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            const Text(
                              'Welcome Back',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Sign in to access your account',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 35),

                            //* Animated Selection Container
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildAnimatedContainer(
                                  isSelected: isStudentSelected,
                                  icon: Icons.school_outlined,
                                  label: "Student",
                                  onTap: () {
                                    setState(() {
                                      isStudentSelected = true;
                                    });
                                  },
                                ),
                                const SizedBox(width: 20),
                                _buildAnimatedContainer(
                                  isSelected: !isStudentSelected,
                                  icon: Icons.person,
                                  label: "Staff",
                                  onTap: () {
                                    setState(() {
                                      isStudentSelected = false;
                                    });
                                  },
                                ),
                              ],
                            ),

                            const SizedBox(height: 35),

                            //*--------- Email and Password Fields
                            _textField(
                              "Email",
                              _emailController,
                            ),
                            const SizedBox(height: 15),
                            _textField(
                              "Password",
                              _passwordController,
                            ),

                            //*--------------------------------------
                            const SizedBox(height: 25),
                            GestureDetector(
                              onTap: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    textAlign: TextAlign.center,
                                    'Sign In',
                                    style: TextStyle(
                                      color: Color(0xFF3D5AFE),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //* Animated Container Widget
  Widget _buildAnimatedContainer({
    required bool isSelected,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return AnimatedContainer(
      height: 80,
      width: 120,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isSelected ? kWhiteColor : kWhiteColor.withAlpha(25),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? kMainColor : kWhiteColor,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                  color: isSelected ? kMainColor : kWhiteColor,
                  fontWeight: FontWeight.w200),
            ),
          ],
        ),
      ),
    );
  }

  //* Text Field Widget
  Widget _textField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $label';
          }
          return null;
        },
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: kWhiteColor.withAlpha(25),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withAlpha(40)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withAlpha(40)),
          ),
        ),
      ),
    );
  }
}

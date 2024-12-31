import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nibm_unity/auth/auth_service.dart';
import 'package:nibm_unity/constants/colors.dart';

import '../widgets/gradient_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final AuthService authService = AuthService();

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLogin = true;
  bool _isLoading = false;
  final _nameController = TextEditingController();
  final _emailRegController = TextEditingController();
  final _passwordRegController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _alertBox(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Support"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(isLogin),
      body: GradientContainer(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBlurredContainer(isDesktop, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(islogin) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: FloatingActionButton(
          onPressed: () {
            _alertBox(islogin
                ? "Enter your LMS email and password to Log in."
                : "Enter your LMS email, name and password to Register. \n (GADSE241F-033@student.nibm.lk)");
          },
          backgroundColor: kWhiteColor,
          child: const Icon(Icons.question_mark_rounded, color: kMainColor),
        ),
      ),
    );
  }

  Widget _buildBlurredContainer(bool isDesktop, BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: isDesktop ? 500 : MediaQuery.of(context).size.width * 0.8,
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: kWhiteColor.withAlpha(15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildBackButton(context),
                const SizedBox(height: 25),
                _buildTitle(),
                const SizedBox(height: 35),
                if (isLogin) ...[
                  _textField("Email", _emailController),
                  const SizedBox(height: 15),
                  _textField("Password", _passwordController),
                ] else ...[
                  _textField("Name", _nameController),
                  const SizedBox(height: 15),
                  _textField(
                    "Email",
                    _emailRegController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Email';
                      }
                      if (!value.endsWith('@student.nibm.lk')) {
                        return 'Please enter a valid student email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  _textField("Password", _passwordRegController),
                  const SizedBox(height: 15),
                  _textField("Confirm Password", _confirmPasswordController,
                      validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordRegController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  }),
                ],
                const SizedBox(height: 25),
                _buildActionButton(context),
                const SizedBox(height: 15),
                _buildToggleText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: () => context.pop(),
        icon: const Icon(Icons.arrow_back, color: kWhiteColor),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        const Text('Welcome Back',
            style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(
            isLogin ? 'Sign in to access your account' : 'Create a new account',
            style: const TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return GestureDetector(
      onTap: _isLoading
          ? null
          : (isLogin
              ? _login
              : _handleRegister), // Disable button while loading
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        decoration: BoxDecoration(
          color: _isLoading
              ? Colors.grey
              : Colors.white, // Grey out button when loading
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          // Use Center for better alignment of loading indicator
          child: _isLoading
              ? const CircularProgressIndicator() // Show loading indicator
              : Text(
                  isLogin ? 'Sign In' : 'Register',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF3D5AFE),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildToggleText() {
    return TextButton(
      onPressed: () => setState(() => isLogin = !isLogin),
      child: Text(
          isLogin
              ? "Don't have an account? Register"
              : "Already have an account? Login",
          style: const TextStyle(color: kWhiteColor)),
    );
  }

  Widget _textField(String label, TextEditingController controller,
      {FormFieldValidator<String>? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: controller,
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your $label';
              }
              return null;
            },
        style: const TextStyle(color: Colors.white),
        obscureText:
            label == "Password" || label == "Confirm Password" ? true : false,
        decoration: InputDecoration(
          filled: true,
          fillColor: kWhiteColor.withAlpha(25),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withAlpha(40))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withAlpha(40))),
        ),
      ),
    );
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Start loading
      });
      final email = _emailController.text;
      final password = _passwordController.text;

      try {
        final response = await authService.signInWithEmail(email, password);
        if (response.user != null &&
            response.user!.emailConfirmedAt != null &&
            response.user!.emailConfirmedAt!.isNotEmpty) {
          // Navigation after successful login and verification
          if (mounted) context.go('/dashboard');
        } else {
          // Prompt user to verify email if not already verified.
          if (mounted) {
            _alertBox('Please verify your email before logging in.');
            // Consider sending a verification email again here if needed:
            // await authService.sendVerificationEmail();
          }
        }
      } catch (e) {
        if (mounted) {
          _alertBox(e.toString());
        }
      } finally {
        setState(() {
          _isLoading = false; // Stop loading
        });
      }
    }
  }

  void _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final regEmail = _emailRegController.text;
      final regPassword = _passwordRegController.text;
      final regName = _nameController.text;

      try {
        final response =
            await authService.signUpWithEmail(regEmail, regPassword, regName);

        if (mounted && response.user != null) {
          _alertBox(
              "Registration successful! Please check your inbox to verify your email.");
          // Send verification email
        }
      } catch (e) {
        if (mounted) {
          _alertBox(e.toString());
        }
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

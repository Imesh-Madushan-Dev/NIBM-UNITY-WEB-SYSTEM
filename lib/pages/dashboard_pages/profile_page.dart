import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nibm_unity/auth/auth_service.dart'; // Import your AuthService

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
  String? userName;
  String? userEmail;
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    userEmail = _authService.getCurrentUser();
    userName = await _authService.fetchUserName(); // Fetch from Supabase
    if (mounted) {
      // Check if widget is still mounted
      setState(() {
        isLoading = false; // Data loaded
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.signOut();
              if (context.mounted) {
                context.go('/home');
              }
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome, $userEmail'),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}

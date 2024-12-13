import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  //* Sign in with email and password
  Future<AuthResponse> signInWithEmail(String email, String password) async {
    final response = await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
    return response;
  }

  //* Sign up with email and password
  Future<AuthResponse> signUpWithEmail(
      String email, String password, String displayName) async {
    final response = await _supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: {
        'display_name': displayName, // Store display name in user metadata
      },
    );
    return response;
  }

  //* Sign out
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  //* Get current user
  String? getCurrentUser() {
    final session = _supabaseClient.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

  //* Fetch user display name
  Future<String?> fetchUserName() async {
    final user = _supabaseClient.auth.currentUser;
    if (user != null) {
      final userMetadata = user.userMetadata;
      return userMetadata?['display_name'] as String?;
    }
    return null;
  }
}

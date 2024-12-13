/*

 Auth Gate - check if the user is authenticated or not
------------------------------------------------------------

  unauthenticated  =>  login
  authenticated    =>  home


 */

import 'package:flutter/cupertino.dart';
import 'package:nibm_unity/pages/dashboard_page.dart';
import 'package:nibm_unity/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      //* Listen to the changes
      stream: Supabase.instance.client.auth.onAuthStateChange,
      //* then build that
      builder: (context, snapshot) {
        //* If the connection state is waiting
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CupertinoActivityIndicator();
        }

        //* If the user is authenticated
        if (snapshot.hasData && snapshot.data != null) {
          return const DashboardPage();
        }

        //* If the user is not authenticated
        return const LoginPage();
      },
    );
  }
}

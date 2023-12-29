import 'package:flutter/material.dart';

import '../service/auth_service.dart';
import '../widgets/widgets.dart';
import 'auth/login_page.dart';

/// HomePage class that will be updated by the end of this project.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

/// HomePageState that currently only includes a logout
/// button. If pressed it would log you out.
class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        child: const Text("Logout"),
        onPressed: () {
          authService.signOut();
          nextScreenReplace(context, const LoginPage());
        },
      )),
    );
  }
}

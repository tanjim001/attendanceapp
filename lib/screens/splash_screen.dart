import 'package:provider/provider.dart';
import 'package:attendenceapp/screens/home_screen.dart';
import 'package:attendenceapp/screens/login_screen.dart';
import 'package:attendenceapp/services/auth_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    //authService.signOut();

    return authService.currentUser == null
        ? const LoginScreen()
        : const HomeScreen();
  }
}

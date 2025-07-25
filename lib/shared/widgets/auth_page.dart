import 'dart:developer';
import 'package:e_commerce_app/core/constants/routes.dart';
import 'package:e_commerce_app/core/database/hive_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final LocalAuthentication auth;
  bool isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported();
    _navigateBasedOnLoginStatus();
  }

  Future<void> _authenticate() async {
    try {
      isAuthenticated = await auth.authenticate(
        localizedReason: " Open the App",
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
        ),
      );

      if (isAuthenticated) {
        context.go(RoutesName.productPath);
      }
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

  Future<void> _navigateBasedOnLoginStatus() async {
    final hiveService = GetIt.instance<HiveService>();
    if (!hiveService.hasInitialized) {
      await hiveService.init();
    }
    final bool isLoggedIn = await hiveService.isLoggedIn();

    if (isLoggedIn) {
      _authenticate();
    } else {
      context.go(RoutesName.loginPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

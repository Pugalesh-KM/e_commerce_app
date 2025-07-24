import 'dart:developer';

import 'package:e_commerce_app/core/constants/routes.dart';
import 'package:e_commerce_app/core/database/hive_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnLoginStatus();
  }

  Future<void> _navigateBasedOnLoginStatus() async {
    final hiveService = GetIt.instance<HiveService>();
    if (!hiveService.hasInitialized) {
      await hiveService.init();
    }
    final bool isLoggedIn = await hiveService.isLoggedIn();
    log('isLoggedIn: ${isLoggedIn.toString()}');

    if (isLoggedIn) {
      context.go(RoutesName.productPath);
    } else {
      context.go(RoutesName.loginPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show a temporary loader while checking login state
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

import 'package:e_commerce_app/core/dependency_injection/injector.dart';
import 'package:e_commerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:e_commerce_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:e_commerce_app/features/product/presentation/cubit/product_cubit.dart';
import 'package:e_commerce_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await init();
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => injector<LoginCubit>()),
        BlocProvider(create: (_) => injector<ProductCubit>()),
        BlocProvider(create: (_) => injector<CartCubit>()),
      ],
      child: MaterialApp.router(
        title: 'E-Commerce App',
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}

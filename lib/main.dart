import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mercanova/config/theme/app_theme.dart';
import 'package:mercanova/infrastructure/cubits/shopping_cart/shopping_cart_cubit.dart';

import 'config/router/app_router.dart';

void main() => runApp(BlocProvider(
    create: (context) => ShoppingCartCubit(),
    child: const MyApp(),
  ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mercanova',
      theme: AppTheme().theme(),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}

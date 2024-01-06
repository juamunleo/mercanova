import 'package:go_router/go_router.dart';
import 'package:mercanova/presentation/screens/screens.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: HomeScreen.route,
      builder: (_, __) => const HomeScreen(),
    ),
    GoRoute(
      path: ScanProductScreen.route,
      builder: (_, __) => const ScanProductScreen()
    ),
    GoRoute(
      path: ShoppingCartScreen.route,
      builder: (_, __) => const ShoppingCartScreen()
    ),
    GoRoute(
      path: CheckoutScreen.route,
      builder: (_, __) => const CheckoutScreen()
    )
  ],
);
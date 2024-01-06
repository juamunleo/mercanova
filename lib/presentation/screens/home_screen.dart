import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mercanova/presentation/screens/scan_product_screen.dart';
import 'package:mercanova/widgets/buttons/big_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    final texts = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.shopping_bag_outlined, size: 40),
      ),
      drawer: const Drawer(),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Text(
            '¡Bienvenido a mercanova!',
            style: texts.headlineMedium),
            const SizedBox(height: 50),
            BigButton(
              label: 'Comprar',
              onPressed: () => context.push(ScanProductScreen.route),
            ),
            const SizedBox(height: 50),
            BigButton(
              label: 'Ofertas',
              onPressed: () {},
            ),
            const SizedBox(height: 50),
            BigButton(
              label: 'Nuevos',
              onPressed: () {},
            ),
            const SizedBox(height: 50),
            BigButton(
              label: 'Consultar productos',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
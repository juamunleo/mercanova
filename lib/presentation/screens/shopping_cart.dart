import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mercanova/infrastructure/cubits/shopping_cart/shopping_cart_cubit.dart';
import 'package:mercanova/presentation/screens/screens.dart';
import 'package:mercanova/widgets/buttons/medium_button.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  static const String route = '/shopping-cart';

  @override
  Widget build(BuildContext context) {
    final products = context.read<ShoppingCartCubit>().products;
    final texts = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu carro'),
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.close_rounded)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _Table(),
            Column(
              children: [
                const Divider(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: texts.headlineLarge,
                    ),
                    Text(
                      '${context.read<ShoppingCartCubit>().totalPrice.toStringAsPrecision(2)} €',
                      style: texts.headlineSmall,
                    )
                  ],
                ),
                const SizedBox(height: 30),
                MediumButton(
                  label: 'Procesar pago',
                  onPressed: (products.isNotEmpty)
                    ? () => context.push(CheckoutScreen.route)
                    : null
                ),
                const SizedBox(height: 20)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _Table extends StatelessWidget {
  const _Table();

  @override
  Widget build(BuildContext context) {
    final products = context.read<ShoppingCartCubit>().products;
    final texts = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: TableBorder(
        horizontalInside: BorderSide(color: colors.onBackground.withAlpha(50)),
        verticalInside: BorderSide(color: colors.onBackground.withAlpha(50))
      ),
      children: [
        TableRow(
          children: [
            Text(
              'Producto',
              textAlign: TextAlign.center,
              style: texts.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              '€/Ud', 
              textAlign: TextAlign.center,
              style: texts.headlineSmall!.copyWith(fontWeight: FontWeight.bold)
            ),
            Text(
              'Uds',
              textAlign: TextAlign.center,
              style: texts.headlineSmall!.copyWith(fontWeight: FontWeight.bold)
            ),
            Text(
              'Total',
              textAlign: TextAlign.center,
              style: texts.headlineSmall!.copyWith(fontWeight: FontWeight.bold)
            )
          ]
        ),
        ...products.map((product) =>
          TableRow(
            children: [
              Text(
                product.name,
                textAlign: TextAlign.center,
                style: texts.headlineSmall,
              ),
              Text(
                '${product.price.toStringAsPrecision(2)} €', 
                textAlign: TextAlign.center,
              ),
              Text(
                products.where((p) => p.type == product.type).length.toString(),
                textAlign: TextAlign.center,
              ),
              Text(
                '${(products.where((p) => p.type == product.type).length*product.price).toStringAsPrecision(2)} €',
                textAlign: TextAlign.center,
              )
            ]
          )).toList(),
      ]
    );
  }
}
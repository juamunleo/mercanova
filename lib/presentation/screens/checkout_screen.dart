import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mercanova/infrastructure/database.dart';
import 'package:mercanova/presentation/screens/screens.dart';
import 'package:mercanova/widgets/buttons/medium_button.dart';

import '../../infrastructure/cubits/shopping_cart/shopping_cart_cubit.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  static const String route = '/checkout';

  @override
  Widget build(BuildContext context) {
    //final products = context.read<ShoppingCartCubit>().products;
    final texts = Theme.of(context).textTheme;
    final products = database;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Procesar pago'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tus métodos de pago',
                style: texts.headlineLarge,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 20),
                  const Icon(Icons.credit_card_rounded),
                  const SizedBox(width: 10),
                  Text(
                    'Tarjeta: ****1234',
                    style: texts.titleMedium,
                  )
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: FilledButton.tonal(
                  onPressed: () {}, 
                  child: Text(
                    'Gestionar métodos de pago',
                    style: texts.titleLarge,
                  )
                )
              ),
              const SizedBox(height: 40),
              const Divider(),
              const SizedBox(height: 40),
              Text(
                'Revisa tu compra',
                style: texts.headlineLarge,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.9,
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    for(int i=0; i<3 && i < products.length; i++)
                      (i < 2)
                        ? Text('${products[i].name}, ')
                        : Text('${products[i].name}, ...')
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: MediumButton(
                  label: 'Ver lista completa',
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 40),
              const Divider(),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total a pagar',
                    style: texts.headlineMedium,
                  ),
                  Text(
                    '${context.read<ShoppingCartCubit>().totalPrice.toStringAsPrecision(2)} €',
                    style: texts.headlineMedium,
                  )
                ],
              ),
              const SizedBox(height: 30),
              Center(
                child: MediumButton(
                  label: 'Pagar ahora',
                  onPressed: () async {
                    await confirmDialog(context);
      
                    WidgetsBinding.instance.addPostFrameCallback((_) => context.go(HomeScreen.route));
                    
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> confirmDialog(BuildContext context) async {
    await showDialog(
      context: context, 
      builder: (dialogContext) => AlertDialog(
        title: const Text('Compra realizada'),
        content: const Text('Se ha terminado de realizar el pago de sus productos.\n\n¡Gracias por su compra!'),
        actions: [
          TextButton(
            child: const Text('Volver'),
            onPressed: () => context.pop()
          ),
        ],
      )
    );
  }
}
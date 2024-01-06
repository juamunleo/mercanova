import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mercanova/infrastructure/cubits/shopping_cart/shopping_cart_cubit.dart';
import 'package:mercanova/infrastructure/database.dart';
import 'package:mercanova/presentation/screens/screens.dart';
import 'package:mercanova/widgets/buttons/medium_button.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

class ScanProductScreen extends StatefulWidget {
  const ScanProductScreen({super.key});

  static const route = '/scan-product';

  @override
  State<ScanProductScreen> createState() => _ScanProductScreenState();
}

class _ScanProductScreenState extends State<ScanProductScreen> {
  int? scannedProductId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir producto'),
        actions: [
          IconButton(
            onPressed: () => context.push(ShoppingCartScreen.route), 
            icon: const Icon(Icons.shopping_cart_outlined)
          )
        ],
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              if(scannedProductId == null && ModalRoute.of(context)!.isCurrent)
                QRCodeDartScanView(
                  scanInvertedQRCode: false,
                  typeScan: TypeScan.live,
                  typeCamera: TypeCamera.back,
                  onCapture: (result) {
                    if(scannedProductId != null) return;

                    setState(() => scannedProductId = int.parse(result.text));
                  },
                  widthPreview: 400,
                  heightPreview: 400
                ),
              if(scannedProductId != null)
                Container(
                  width: 400,
                  height: 400,
                  color: Colors.black,
                ),
              const SizedBox(height: 25),
              if(scannedProductId != null)
                _ProductAction(
                  id: scannedProductId!,
                  onCancel: () => setState(() => scannedProductId = null)
                )
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductAction extends StatelessWidget {
  final int id;
  final void Function() onCancel;

  const _ProductAction({
    required this.id,
    required this.onCancel
  });

  @override
  Widget build(BuildContext context) {
    final texts = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          database.where((product) => product.id == id).firstOrNull?.name ?? 'Desconocido',
          style: texts.displayLarge,
        ),
        const SizedBox(height: 20),
        MediumButton(
          label: 'Añadir al carro',
          onPressed: () => confirmAdding(context),
        ),
        const SizedBox(height: 20),
        MediumButton(
          label: 'Volver a intentarlo',
          onPressed: onCancel,
        )
      ],
    );
  }

  void confirmAdding(BuildContext context) {
    showDialog(
      context: context, 
      builder: (dialogContext) => AlertDialog(
        title: const Text('Añadir producto al carro'),
        content: const Text('¿Seguro que desea añadir este producto a su carro?'),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => context.pop()
          ),
          TextButton(
            child: const Text('Aceptar'),
            onPressed: () {
              final product = database.where((p) => p.id == id).first;
              context.read<ShoppingCartCubit>().addProduct(product);
              context.pop();
            }
          )
        ],
      )
    );
  }
}
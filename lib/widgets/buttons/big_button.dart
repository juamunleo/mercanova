import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;

  const BigButton({
    super.key,
    required this.label,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    final texts = Theme.of(context).textTheme;
    return FilledButton.tonal(
      style: const ButtonStyle(
        minimumSize: MaterialStatePropertyAll(Size(350,100))
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          label,
          style: texts.headlineMedium,
        ),
      )
    );
  }
}
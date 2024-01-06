import 'package:flutter/material.dart';

class MediumButton extends StatelessWidget {
  final String label;
  final void Function()? onPressed;

  const MediumButton({
    super.key,
    required this.label,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    final texts = Theme.of(context).textTheme;
    return FilledButton.tonal(
      style: const ButtonStyle(
        minimumSize: MaterialStatePropertyAll(Size(350,50))
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
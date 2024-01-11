import 'package:flutter/material.dart';

class TextBody extends StatelessWidget {
  final String text;
  const TextBody({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text( text, style: Theme.of(context).textTheme.bodyMedium,);
  }
}

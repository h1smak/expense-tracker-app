import 'package:flutter/material.dart';

class Amount extends StatelessWidget {
  const Amount({super.key, required this.amountController});

  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: amountController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          prefixText: '\$ ',
          label: Text('Amount'),
        ),
      ),
    );
  }
}

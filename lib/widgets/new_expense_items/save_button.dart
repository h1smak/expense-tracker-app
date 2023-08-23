import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key, required this.submitExpenseData});

  final void Function() submitExpenseData;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: submitExpenseData,
      child: const Text('Save Expense'),
    );
  }
}

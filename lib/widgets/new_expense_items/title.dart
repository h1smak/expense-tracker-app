import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.titleController});

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: titleController,
        maxLength: 50,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          label: Text('Title'),
        ),
      ),
    );
  }
}

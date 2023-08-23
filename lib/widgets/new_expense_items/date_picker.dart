import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class DatePicker extends StatelessWidget {
  const DatePicker(
      {super.key, required this.selectedDate, required this.presentDatePicker});

  final DateTime? selectedDate;
  final Function() presentDatePicker;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          selectedDate == null
              ? 'No date selected'
              : formatter.format(selectedDate!),
        ),
        IconButton(
          onPressed: presentDatePicker,
          icon: const Icon(Icons.calendar_month),
        ),
      ],
    );
  }
}

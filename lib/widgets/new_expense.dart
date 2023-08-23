import 'package:expense_tracker/widgets/new_expense_items/cancel_button.dart';
import 'package:expense_tracker/widgets/new_expense_items/date_picker.dart';
import 'package:expense_tracker/widgets/new_expense_items/dropdown_button.dart';
import 'package:expense_tracker/widgets/new_expense_items/save_button.dart';
import 'package:expense_tracker/widgets/new_expense_items/title.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense_items/amount.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyBoardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TitleText(
                          titleController: _titleController,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Amount(
                          amountController: _amountController,
                        ),
                      ),
                    ],
                  )
                else
                  TitleText(titleController: _titleController),
                if (width >= 600)
                  Row(
                    children: [
                      CategoryDropdown(
                        selectedCategory: _selectedCategory,
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: DatePicker(
                          selectedDate: _selectedDate,
                          presentDatePicker: _presentDatePicker,
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: Amount(amountController: _amountController),
                      ),
                      Expanded(
                        child: DatePicker(
                          selectedDate: _selectedDate,
                          presentDatePicker: _presentDatePicker,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      const CancelButton(),
                      SaveButton(
                        submitExpenseData: _submitExpenseData,
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      CategoryDropdown(
                        selectedCategory: _selectedCategory,
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const Spacer(),
                      const CancelButton(),
                      SaveButton(
                        submitExpenseData: _submitExpenseData,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

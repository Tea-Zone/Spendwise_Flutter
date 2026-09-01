import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/expense.dart';
import '../widgets/expense_card.dart';

class ExpenseScreen extends StatefulWidget {
  final List<Expense> expenses;
  final Function(Expense) onAddExpense;
  final Function(Expense) onDeleteExpense;

  const ExpenseScreen({
    super.key,
    required this.expenses,
    required this.onAddExpense,
    required this.onDeleteExpense,
  });

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final TextEditingController _titleController =
  TextEditingController();

  final TextEditingController _amountController =
  TextEditingController();

  ExpenseCategory _selectedCategory =
      ExpenseCategory.other;

  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitExpense() {
    final enteredTitle =
    _titleController.text.trim();

    final enteredAmount =
    double.tryParse(_amountController.text);

    if (enteredTitle.isEmpty ||
        enteredAmount == null ||
        enteredAmount <= 0) {
      return;
    }

    final expense = Expense(
      title: enteredTitle,
      amount: enteredAmount,
      category: _selectedCategory,
      date: _selectedDate,
    );

    widget.onAddExpense(expense);

    _titleController.clear();
    _amountController.clear();

    setState(() {
      _selectedCategory = ExpenseCategory.other;
      _selectedDate = DateTime.now();
    });
  }

  Future<void> _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate == null) {
      return;
    }

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topRight,
          radius: 1.1,
          colors: [
            Color(0xFF30202C),
            Color(0xFF151218),
          ],
        ),
      ),

      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              18,
              8,
              18,
              12,
            ),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [
                Text(
                  'Track the little things.',
                  style: GoogleFonts.caveat(
                    fontSize: 31,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFF3EAF0),
                  ),
                ),

                Text(
                  'Keep your spending in one place.',
                  style: GoogleFonts.caveat(
                    fontSize: 18,
                    color: const Color(0xFF91858F),
                  ),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Expense title',
                    prefixIcon:
                    Icon(Icons.edit_outlined),
                  ),
                ),

                const SizedBox(height: 11),

                TextField(
                  controller: _amountController,
                  keyboardType:
                  TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    prefixIcon:
                    Icon(Icons.currency_rupee_rounded),
                  ),
                ),

                const SizedBox(height: 11),

                DropdownButtonFormField<
                    ExpenseCategory>(
                  value: _selectedCategory,

                  decoration: const InputDecoration(
                    labelText: 'Category',
                    prefixIcon:
                    Icon(Icons.category_outlined),
                  ),

                  items: ExpenseCategory.values
                      .map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(
                        category.name,
                        style: GoogleFonts.caveat(
                          fontSize: 18,
                        ),
                      ),
                    );
                  }).toList(),

                  onChanged: (category) {
                    if (category == null) {
                      return;
                    }

                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 18,
                      color: Color(0xFFC76A91),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                        style: GoogleFonts.caveat(
                          fontSize: 18,
                          color: const Color(
                            0xFFD5CDD3,
                          ),
                        ),
                      ),
                    ),

                    TextButton(
                      onPressed: _selectDate,
                      child: Text(
                        'Change',
                        style: GoogleFonts.caveat(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 3),

                SizedBox(
                  width: double.infinity,

                  child: FilledButton.icon(
                    onPressed: _submitExpense,
                    icon: const Icon(
                      Icons.add_rounded,
                    ),
                    label: Text(
                      'Add Expense',
                      style: GoogleFonts.caveat(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: widget.expenses.isEmpty
                ? Center(
              child: Text(
                'Nothing spent yet.',
                style: GoogleFonts.caveat(
                  fontSize: 22,
                  color: const Color(
                    0xFF817780,
                  ),
                ),
              ),
            )
                : ListView.builder(
              padding:
              const EdgeInsets.only(
                bottom: 20,
              ),

              itemCount:
              widget.expenses.length,

              itemBuilder:
                  (context, index) {
                final expense =
                widget.expenses[index];

                return Dismissible(
                  key: ValueKey(expense),

                  direction:
                  DismissDirection.endToStart,

                  onDismissed: (_) {
                    widget.onDeleteExpense(
                      expense,
                    );
                  },

                  background: Container(
                    alignment:
                    Alignment.centerRight,

                    padding:
                    const EdgeInsets.only(
                      right: 24,
                    ),

                    decoration:
                    BoxDecoration(
                      color: const Color(
                        0xFF7D3F55,
                      ),
                      borderRadius:
                      BorderRadius.circular(
                        18,
                      ),
                    ),

                    child: const Icon(
                      Icons.delete_outline,
                      color: Colors.white,
                    ),
                  ),

                  child: ExpenseCard(
                    expense: expense,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
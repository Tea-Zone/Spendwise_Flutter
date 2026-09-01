import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/expense.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;

  const ExpenseCard({
    super.key,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 5,
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Row(
          children: [
            Container(
              width: 4,
              height: 50,

              decoration: BoxDecoration(
                color: const Color(0xFFC76A91),
                borderRadius:
                BorderRadius.circular(10),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [
                  Text(
                    expense.title,
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,

                    style: GoogleFonts.caveat(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: const Color(
                        0xFFF1E9EE,
                      ),
                    ),
                  ),

                  const SizedBox(height: 2),

                  Row(
                    children: [
                      Text(
                        expense.category.name
                            .toUpperCase(),

                        style: GoogleFonts.caveat(
                          fontSize: 14,
                          fontWeight:
                          FontWeight.w700,
                          color:
                          const Color(0xFFC76A91),
                        ),
                      ),

                      const SizedBox(width: 7),

                      const Text(
                        '•',
                        style: TextStyle(
                          color: Color(0xFF625961),
                        ),
                      ),

                      const SizedBox(width: 7),

                      Text(
                        '${expense.date.day}/${expense.date.month}/${expense.date.year}',

                        style: GoogleFonts.caveat(
                          fontSize: 15,
                          color: const Color(
                            0xFF817780,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Text(
              '₹${expense.amount.toStringAsFixed(2)}',

              style: GoogleFonts.caveat(
                fontSize: 21,
                fontWeight: FontWeight.w700,
                color: const Color(
                  0xFFF3DCE6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
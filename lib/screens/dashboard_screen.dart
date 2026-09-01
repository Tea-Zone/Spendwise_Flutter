import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/expense.dart';
import '../models/todo.dart';

import '../widgets/dashboard_metric_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.expenses,
    required this.todos,
  });

  final List<Expense> expenses;
  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();

    final double totalSpent =
    expenses.fold<double>(
      0,
          (
          double sum,
          Expense expense,
          ) {
        return sum + expense.amount;
      },
    );

    final double todaySpent =
    expenses
        .where(
          (Expense expense) {
        return expense.date.year == now.year &&
            expense.date.month == now.month &&
            expense.date.day == now.day;
      },
    )
        .fold<double>(
      0,
          (
          double sum,
          Expense expense,
          ) {
        return sum + expense.amount;
      },
    );

    final int completedTasks =
        todos
            .where(
              (Todo todo) {
            return todo.isDone;
          },
        )
            .length;

    final int todayTasks =
        todos
            .where(
              (Todo todo) {
            return todo.createdAt.year == now.year &&
                todo.createdAt.month == now.month &&
                todo.createdAt.day == now.day;
          },
        )
            .length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: GoogleFonts.caveat(
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topRight,
            radius: 1.3,
            colors: [
              Color(0xFF30202C),
              Color(0xFF151218),
            ],
          ),
        ),

        child: ListView(
          padding: const EdgeInsets.all(16),

          children: [
            Text(
              'A little look at your life.',
              style: GoogleFonts.caveat(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFF3EAF0),
              ),
            ),

            const SizedBox(height: 4),

            Text(
              'Money spent. Things done.',
              style: GoogleFonts.caveat(
                fontSize: 19,
                color: const Color(0xFF91858F),
              ),
            ),

            const SizedBox(height: 20),

            DashboardMetricCard(
              label: 'Total Spent',
              value:
              '₹${totalSpent.toStringAsFixed(2)}',
              icon:
              Icons.account_balance_wallet_outlined,
              color:
              const Color(0xFFC76A91),
            ),

            DashboardMetricCard(
              label: "Today's Spending",
              value:
              '₹${todaySpent.toStringAsFixed(2)}',
              icon: Icons.today_outlined,
              color:
              const Color(0xFFB48AA0),
            ),

            DashboardMetricCard(
              label: 'Tasks Completed',
              value:
              '$completedTasks / ${todos.length}',
              icon:
              Icons.check_circle_outline,
              color:
              const Color(0xFF8EAF9B),
            ),

            DashboardMetricCard(
              label: 'Tasks Added Today',
              value: '$todayTasks',
              icon:
              Icons.playlist_add_check_outlined,
              color:
              const Color(0xFFC5A77D),
            ),
          ],
        ),
      ),
    );
  }
}
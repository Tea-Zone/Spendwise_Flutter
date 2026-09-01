import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../models/todo.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    required this.todo,
    required this.onChanged,
  });

  final Todo todo;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: todo.isDone,

      onChanged: onChanged,

      activeColor:
      const Color(0xFFC76A91),

      checkColor: Colors.white,

      contentPadding:
      const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 4,
      ),

      controlAffinity:
      ListTileControlAffinity.leading,

      title: Text(
        todo.title,

        style: GoogleFonts.caveat(
          fontSize: 22,
          fontWeight: FontWeight.w600,

          color: todo.isDone
              ? const Color(0xFF746A72)
              : const Color(0xFFF1E9EE),

          decoration: todo.isDone
              ? TextDecoration.lineThrough
              : null,

          decorationColor:
          const Color(0xFFC76A91),
        ),
      ),

      subtitle: Padding(
        padding:
        const EdgeInsets.only(top: 3),

        child: Row(
          children: [
            Icon(
              todo.isDone
                  ? Icons.done_all_rounded
                  : Icons.schedule_rounded,

              size: 14,

              color: todo.isDone
                  ? const Color(0xFFC76A91)
                  : const Color(0xFF746C74),
            ),

            const SizedBox(width: 5),

            Text(
              todo.isDone
                  ? 'Completed'
                  : 'Added ${DateFormat.yMMMd().format(todo.createdAt)}',

              style: GoogleFonts.caveat(
                fontSize: 16,

                color: todo.isDone
                    ? const Color(0xFF9C7185)
                    : const Color(0xFF746C74),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
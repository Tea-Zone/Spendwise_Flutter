import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/todo.dart';
import '../widgets/todo_tile.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({
    super.key,
    required this.todos,
    required this.onAddTodo,
    required this.onToggleTodo,
    required this.onDeleteTodo,
  });

  final List<Todo> todos;
  final ValueChanged<String> onAddTodo;
  final ValueChanged<int> onToggleTodo;
  final ValueChanged<int> onDeleteTodo;

  @override
  State<TodoScreen> createState() {
    return _TodoScreenState();
  }
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _taskController =
  TextEditingController();

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void _submitTodo() {
    final String taskTitle =
    _taskController.text.trim();

    if (taskTitle.isEmpty) {
      return;
    }

    widget.onAddTodo(taskTitle);
    _taskController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topLeft,
          radius: 1.2,
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
              16,
              10,
              16,
              8,
            ),

            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(13),

                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller:
                        _taskController,

                        style: GoogleFonts.caveat(
                          fontSize: 20,
                        ),

                        decoration:
                        const InputDecoration(
                          labelText: 'New task',
                          prefixIcon: Icon(
                            Icons
                                .radio_button_unchecked,
                          ),
                          border:
                          InputBorder.none,
                          filled: false,
                        ),

                        onSubmitted: (_) {
                          _submitTodo();
                        },
                      ),
                    ),

                    const SizedBox(width: 8),

                    FilledButton(
                      onPressed: _submitTodo,

                      style:
                      FilledButton.styleFrom(
                        minimumSize:
                        const Size(52, 48),
                      ),

                      child: const Icon(
                        Icons.add_rounded,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: widget.todos.isEmpty
                ? Center(
              child: Column(
                mainAxisSize:
                MainAxisSize.min,

                children: [
                  const Icon(
                    Icons
                        .format_list_bulleted_rounded,
                    size: 48,
                    color: Color(0xFF4D454D),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'Your list is clear.',
                    style: GoogleFonts.caveat(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: const Color(
                        0xFFB0A5AD,
                      ),
                    ),
                  ),

                  Text(
                    'Add something worth doing.',
                    style: GoogleFonts.caveat(
                      fontSize: 18,
                      color: const Color(
                        0xFF716872,
                      ),
                    ),
                  ),
                ],
              ),
            )

                : ListView.builder(
              padding:
              const EdgeInsets.fromLTRB(
                12,
                4,
                12,
                20,
              ),

              itemCount:
              widget.todos.length,

              itemBuilder:
                  (BuildContext context,
                  int index) {
                final Todo todo =
                widget.todos[index];

                return Dismissible(
                  key: ValueKey<Todo>(todo),

                  direction:
                  DismissDirection
                      .endToStart,

                  onDismissed: (_) {
                    widget.onDeleteTodo(
                      index,
                    );
                  },

                  background: Container(
                    alignment:
                    Alignment.centerRight,

                    padding:
                    const EdgeInsets.only(
                      right: 22,
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

                  child: Card(
                    child: TodoTile(
                      todo: todo,
                      onChanged: (_) {
                        widget.onToggleTodo(
                          index,
                        );
                      },
                    ),
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
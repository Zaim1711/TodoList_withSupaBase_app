import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_app/cubit/todo_cubit.dart';
import 'package:todolist_app/model/todo_model.dart';
import 'package:todolist_app/screen/todo_screen_add.dart';
import 'package:todolist_app/widget/buildMenuCard.dart';

class TodoScreenModern extends StatefulWidget {
  const TodoScreenModern({super.key});

  @override
  State<TodoScreenModern> createState() => _TodoScreenModernState();
}

class _TodoScreenModernState extends State<TodoScreenModern> {
  @override
  void initState() {
    context.read<TodoCubit>().fetchTodos();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List Modern')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2,
              children: [
                buildMenuCard(
                  color: Color(0XA17990F8).withAlpha(40),
                  iconColor: Color(0XA17990F8),
                  icon: Icons.favorite,
                  count: '${context.watch<TodoCubit>().state.length}',
                  title: 'All Task ',
                ),
                buildMenuCard(
                  color: Color(0XA146CF8B).withAlpha(40),
                  iconColor: Color(0XA146CF8B),
                  icon: Icons.check_circle,
                  count: '0',
                  title: 'Completed',
                ),
                buildMenuCard(
                  color: Color(0XA1BC5EAD).withAlpha(40),
                  iconColor: Color(0XA1BC5EAD),
                  icon: Icons.pending,
                  count: '0',
                  title: 'Pending',
                ),
                buildMenuCard(
                  color: Color(0XA1908986).withAlpha(40),
                  iconColor: Color(0XA1908986),
                  icon: Icons.delete,
                  count: '0',
                  title: 'Deleted',
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // Tambahkan logika untuk memuat ulang daftar tugas
              },
              child: BlocBuilder<TodoCubit, List<TodoModel>>(
                builder: (context, state) {
                  final todos = state;
                  if (todos.isEmpty) {
                    return const Center(
                      child: Text(
                        'Tidak ada tugas. Tambahkan tugas baru!',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount:
                        todos.length, // Ganti dengan jumlah tugas sebenarnya
                    itemBuilder: (context, index) {
                      // Ganti dengan logika untuk menampilkan setiap tugas
                      final todo = todos[index];

                      return ListTile(
                        title: Text(
                          todo.title,
                          style: TextStyle(
                            decoration: todo.isDone
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        leading: Checkbox(
                          value: todo.isDone,
                          onChanged: (_) {
                            context.read<TodoCubit>().toggleDone(todo);
                          },
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            context.read<TodoCubit>().deleteTodo(todo.id);
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 32, color: Colors.white),
        backgroundColor: Color(0xff393433),
        onPressed: () {
          // Tambahkan logika untuk menambahkan tugas baru
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TodoScreen()),
          );
        },
      ),
    );
  }
}

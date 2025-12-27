import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_app/Service/todo_service.dart';
import 'package:todolist_app/model/todo_model.dart';

class TodoCubit extends Cubit<List<TodoModel>> {
  final TodoService _service;

  TodoCubit(super.initialState, this._service);

  Future<void> fetchTodos() async {
    try {
      final todos = await _service.fetchTodos();
      emit(todos);
    } catch (e) {
      emit(state); // Handle error appropriately
      rethrow;
    }
  }

  Future<void> addTodo(String title) async {
    try {
      await _service.addTodo(title);
      await fetchTodos();
    } catch (e) {
      emit(state); // Handle error appropriately
      rethrow;
    }
  }

  Future<void> toggleDone(TodoModel todo) async {
    try {
      await _service.toggleTodoDone(todo.id, todo.isDone);
      await fetchTodos();
    } catch (e) {
      emit(state); // Handle error appropriately
      rethrow;
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _service.deleteTodo(id);
      await fetchTodos();
    } catch (e) {
      emit(state); // Handle error appropriately
      rethrow;
    }
  }
}

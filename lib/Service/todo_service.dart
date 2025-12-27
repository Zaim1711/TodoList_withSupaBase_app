import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todolist_app/model/todo_model.dart';

class TodoService {
  final _client = Supabase.instance.client;

  Future<List<TodoModel>> fetchTodos() async {
    return run(() async {
      final response = await _client
          .from('todos')
          .select()
          .order('created_at', ascending: false);

      return TodoModel.fromJsonList(response);
    });
  }

  Future<void> addTodo(String title) async {
    return run(() async {
      await _client.from('todos').insert({
        'title': title,
        'is_done': false,
        'created_at': DateTime.now().toIso8601String(),
      });
    });
  }

  Future<void> toggleTodoDone(String id, bool isDone) async {
    return run(() async {
      await _client.from('todos').update({'is_done': !isDone}).eq('id', id);
    });
  }

  Future<void> deleteTodo(String id) async {
    return run(() async {
      await _client.from('todos').delete().eq('id', id);
    });
  }

  Future<T> run<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } on PostgrestException catch (e) {
      throw Exception('Supabase error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}

class ServerException implements Exception {
  final String message;
  ServerException({this.message = 'Server error'});
}

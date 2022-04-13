import '../data_source/todo_local_data_source.dart';
import '../model/todo.dart';

class TodoRepository {
  final TodoLocalDataSource _localDataSource;

  TodoRepository(this._localDataSource);

  Future<List<Todo>> getTodos() async => _localDataSource.getTodos();

  Future<List<Todo>> search(String keyword) async =>
      _localDataSource.search(keyword);

  Future<int> insertTodo(Todo todo) => _localDataSource.insertTodo(todo);

  Future<int> updateTodo(Todo todo) => _localDataSource.updateTodo(todo);

  Future<bool> deleteTodo(int id) => _localDataSource.deleteTodo(id);

  Future deleteAllTodos() => _localDataSource.deleteAllTodos();
}

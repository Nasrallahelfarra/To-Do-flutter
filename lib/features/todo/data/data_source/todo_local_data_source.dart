import 'package:objectbox/objectbox.dart';

import '../model/todo.dart';

class TodoLocalDataSource {
  final Box<Todo> _box;

  TodoLocalDataSource(this._box);

  //Adds new Todo records
  Future<int> insertTodo(Todo todo) async => _box.put(todo);

  //Get All Todo items
  Future<List<Todo>> getTodos() async => _box.getAll();

  //Get All Todo items
  Future<List<Todo>> search(String keyword) async => _box
      .getAll()
      .where((element) => element.description.contains(keyword))
      .toList();

  //Update Todo record
  Future<int> updateTodo(Todo todo) async => _box.put(todo);

  //Delete Todo records
  Future<bool> deleteTodo(int id) async => _box.remove(id);

  //We are not going to use this in the demo
  Future deleteAllTodos() async => _box.removeAll();
}

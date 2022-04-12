import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reactive_todo_app/database/database.dart';
import 'package:reactive_todo_app/model/todo.dart';

class TodoDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Todo records
  Future<int> createTodo(Todo todo) async {
    final db = await dbProvider.getDatabase();
    var result = db.insert(todoTABLE, todo.toDatabaseJson());
    return result;
  }

  //Get All Todo items
  //Searches if query string was passed
  Future<List<Todo>?> getTodos({List<String>? columns, String? query}) async {
   // debugPrint('asasdasdas');

    final db = await dbProvider.getDatabase();
    debugPrint('ssssssss');
    List<Map<String, dynamic>> ?result;
    if (query != null) {
      debugPrint('ssssssss $query');

      if (query
          .trim()
          .length != 0) {
        result = await db.query(todoTABLE,
            columns: columns,
            where: 'description LIKE ?',
            whereArgs: ["%$query%"]);
      } else{
        debugPrint('ssssssss1 $query');
        result = await db.query(todoTABLE);

        //result = await db.rawQuery('SELECT * FROM $todoTABLE');
      }

    }else{
      debugPrint('ssssssss1 $query');
      result = await db.query(todoTABLE);

     // result = await db.rawQuery('SELECT * FROM $todoTABLE');
    }
    List<Todo> todos = result.isNotEmpty
        ? result.map((item) => Todo.fromDatabaseJson(item)).toList()
        : [];

    return todos;  }
  //Update Todo record
  Future<int> updateTodo(Todo todo) async {
    final db = await dbProvider.getDatabase();

    var result = await db.update(todoTABLE, todo.toDatabaseJson(),
        where: "id = ?", whereArgs: [todo.id]);

    return result;
  }

  //Delete Todo records
  Future<int> deleteTodo(int id) async {
    final db = await dbProvider.getDatabase();
    var result = await db.delete(todoTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  //We are not going to use this in the demo
  Future deleteAllTodos() async {
    final db = await dbProvider.getDatabase();
    var result = await db.delete(
      todoTABLE,
    );

    return result;
  }
}

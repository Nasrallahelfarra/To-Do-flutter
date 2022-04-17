import 'package:flutter_test/flutter_test.dart';
import 'package:objectbox/objectbox.dart';
import 'package:reactive_todo_app/features/todo/data/model/todo.dart';

class FakeTodoBox extends Fake implements Box<Todo> {
  static List<Todo> stubbedResults = [];

  @override
  List<Todo> getAll() => stubbedResults;

  @override
  int put(Todo object, {PutMode mode = PutMode.put}) {
    final int index =
        stubbedResults.indexWhere((element) => element.id == object.id);
    if (index != -1) {
      stubbedResults[index] = object;
    } else {
      stubbedResults.add(object);
    }
    return object.id;
  }

  @override
  bool remove(int id) {
    stubbedResults.removeWhere((element) => element.id == id);
    return true;
  }
}

mockTodoBoxResult({required List<Todo> results}) {
  FakeTodoBox.stubbedResults.addAll(results);
}

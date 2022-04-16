import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:objectbox/objectbox.dart';
import 'package:reactive_todo_app/features/todo/data/model/todo.dart';
import 'package:reactive_todo_app/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:reactive_todo_app/features/todo/presentation/cubit/todo_state.dart';
import 'package:reactive_todo_app/main.dart';

void main() {
  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Store store = FakeObjectBoxStore();
    await init(store: store);
    sl.allowReassignment = true;
    sl.registerFactory<Box<Todo>>(() => FakeTodoBox());
  });


  group('get todo', () {

    final List<Todo> todos = [
      Todo('Pray'),
      Todo('Eat'),
      Todo('Work'),
    ];

    blocTest(
      'cubit emits TodoLoadedState when todo box is not empty',
      setUp: () => mockTodoBoxResult(results: todos),
      build: () => sl<TodoCubit>(),
    );

    blocTest(
      'cubit emits TodoLoadedState when search with known keyword',
      setUp: () => mockTodoBoxResult(results: todos),
      build: () => sl<TodoCubit>(),
    );

    blocTest(
      'cubit emits TodoEmptyState when search with unknown keyword',
      setUp: () => mockTodoBoxResult(results: todos),
      build: () => sl<TodoCubit>(),
    );
  });

  group('todo operations', () {
    List<Todo> todos = [
      Todo.create(1, 'Pray'),
      Todo.create(2, 'Eat'),
      Todo.create(3, 'Work'),
    ];

    final Todo newTodo = Todo.create(4, 'Sport');

    blocTest(
      'cubit emits TodoLoadedState with new item after add todo item',
      setUp: () => mockTodoBoxResult(results: todos),
      build: () => sl<TodoCubit>(),
    );
  });

  tearDown(() async {
    FakeTodoBox.stubbedResults.clear();
    await sl.reset();
  });
}

mockTodoBoxResult({required List<Todo> results}) {
  FakeTodoBox.stubbedResults.addAll(results);
}

class FakeObjectBoxStore extends Fake implements Store {}

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

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
    await registerFactories(store: store);
    sl.allowReassignment = true;
    sl.registerFactory<Box<Todo>>(() => FakeTodoBox());
  });

  test('cubit initial state should be empty', () {
    expect(sl<TodoCubit>().state, equals(TodoInitialState()));
  });

  blocTest(
    'cubit emits TodoEmptyState when todo box is empty',
    setUp: () => mockTodoBoxResult(results: []),
    build: () => sl<TodoCubit>(),
    act: (TodoCubit cubit) => cubit.getTodos(),
    expect: () => [
      TodoEmptyState(),
    ],
  );

  tearDown(() async {
    FakeTodoBox.stubbedResults = [];
    await sl.reset();
  });
}

mockTodoBoxResult({required List<Todo> results}) {
  FakeTodoBox.stubbedResults = results;
}

class FakeObjectBoxStore extends Fake implements Store {}

class FakeTodoBox extends Fake implements Box<Todo> {
  static List<Todo> stubbedResults = [];

  @override
  List<Todo> getAll() => stubbedResults;
}

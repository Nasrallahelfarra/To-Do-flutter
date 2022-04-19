import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:objectbox/objectbox.dart';
import 'package:reactive_todo_app/features/todo/data/model/todo.dart';
import 'package:reactive_todo_app/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:reactive_todo_app/features/todo/presentation/cubit/todo_state.dart';
import 'package:reactive_todo_app/main.dart';

import 'helpers/fake_object_box_store.dart';
import 'helpers/fake_todo_box.dart';

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
      act: (TodoCubit cubit) => cubit.getTodos(),
      expect: () => [
        TodoLoadedState(todos),
      ],
    );

    blocTest(
      'cubit emits TodoLoadedState when todo box is  empty',
      setUp: () => mockTodoBoxResult(results: []),
      build: () => sl<TodoCubit>(),
      act: (TodoCubit cubit) => cubit.getTodos(),
      expect: () => [
        TodoEmptyState(),
      ],
    );

    blocTest(
      'cubit emits TodoLoadedState when search with known keyword',
      setUp: () => mockTodoBoxResult(results: todos),
      build: () => sl<TodoCubit>(),
      act: (TodoCubit cubit) => cubit.search(todos.first.description),
      expect: () => [
        TodoLoadedState([todos.first])
      ],
    );

    blocTest(
      'cubit emits TodoEmptyState when search with unknown keyword',
      setUp: () => mockTodoBoxResult(results: todos),
      build: () => sl<TodoCubit>(),
      act: (TodoCubit cubit) => cubit.search('nunkonw'),
      expect: () => [
        TodoEmptyState(),
      ],
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
      act: (TodoCubit cubit) => cubit.addTodo(newTodo),
      expect: () => [
        TodoLoadedState(todos..add(newTodo)),
      ],
      verify: (TodoCubit cubit) {
        expect((cubit.state as TodoLoadedState).items.length, equals(4));
      },
    );
  });

  tearDown(() async {
    FakeTodoBox.stubbedResults.clear();
    await sl.reset();
  });
}

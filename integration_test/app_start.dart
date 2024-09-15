import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:objectbox/objectbox.dart';
import 'package:reactive_todo_app/core/object_box/object_box.dart';
import 'package:reactive_todo_app/features/todo/data/data_source/todo_local_data_source.dart';
import 'package:reactive_todo_app/features/todo/data/model/todo.dart';
import 'package:reactive_todo_app/features/todo/data/repository/todo_repository.dart';
import 'package:reactive_todo_app/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:reactive_todo_app/main.dart';

import 'steps/add_to_do_step.dart';
import 'steps/edite_to_do_step.dart';
import 'steps/remove_to_do_step.dart';
import 'steps/view_home_steps.dart';

main() async {
  enableFlutterDriverExtension();
  WidgetsFlutterBinding.ensureInitialized();

  final ObjectBox objectBox = await ObjectBox.create();
  final store = objectBox.store;

  sl.registerFactory<Box<Todo>>(() => store.box<Todo>());
  sl.registerFactory<TodoLocalDataSource>(() => TodoLocalDataSource(sl()));
  sl.registerFactory<TodoRepository>(() => TodoRepository(sl()));
  sl.registerFactory<TodoCubit>(() => TodoCubit(sl()));
  group('TODO :', () {
    testWidgets(
      'App TODO ',
      (WidgetTester tester) async {
        // Initialing Application for Testing and waiting for it to launch
        tester.pumpWidget(MyApp());
        ViewHomeSteps viewHomeSteps=ViewHomeSteps(tester);
        AddToDo addToDo=AddToDo(tester);
        EditToDo editToDo=EditToDo(tester);
        RemoveToDo removeToDo=RemoveToDo(tester);
        await viewHomeSteps.main();
        await addToDo.main();
        await editToDo.main();
        await removeToDo.main();
      },
      skip: false,
      timeout: const Timeout(Duration(minutes: 5)),
    );
  });
}

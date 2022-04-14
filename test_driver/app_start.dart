
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:objectbox/objectbox.dart';
import 'package:reactive_todo_app/core/object_box/object_box.dart';
import 'package:reactive_todo_app/features/todo/data/data_source/todo_local_data_source.dart';
import 'package:reactive_todo_app/features/todo/data/model/todo.dart';
import 'package:reactive_todo_app/features/todo/data/repository/todo_repository.dart';
import 'package:reactive_todo_app/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:reactive_todo_app/main.dart';
main() async {
  enableFlutterDriverExtension();
  WidgetsFlutterBinding.ensureInitialized();

  objectBox = await ObjectBox.create();
  final store = objectBox.store;

  sl.registerFactory<Box<Todo>>(() => store.box<Todo>());
  sl.registerFactory<TodoLocalDataSource>(() => TodoLocalDataSource(sl()));
  sl.registerFactory<TodoRepository>(() => TodoRepository(sl()));
  sl.registerFactory<TodoCubit>(() => TodoCubit(sl()));
  runApp(MyApp());

}
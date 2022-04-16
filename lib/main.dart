import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reactive_todo_app/features/todo/data/data_source/todo_local_data_source.dart';
import 'package:reactive_todo_app/features/todo/data/model/todo.dart';
import 'package:reactive_todo_app/features/todo/data/repository/todo_repository.dart';
import 'package:reactive_todo_app/features/todo/presentation/cubit/todo_cubit.dart';

import 'core/object_box/object_box.dart';
import 'core/object_box/objectbox.g.dart';
import 'features/todo/presentation/ui/home_page.dart';


GetIt sl = GetIt.instance;

Future<void> init({required Store store}) async {
  sl.registerFactory<Box<Todo>>(() => store.box<Todo>());
  sl.registerFactory<TodoLocalDataSource>(() => TodoLocalDataSource(sl()));
  sl.registerFactory<TodoRepository>(() => TodoRepository(sl()));
  sl.registerFactory<TodoCubit>(() => TodoCubit(sl()));
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ObjectBox objectBox = await ObjectBox.create();
  await init(store: objectBox.store);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reactive Flutter',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        canvasColor: Colors.transparent
      ),
      //Our only screen/page we have
      home: HomePage(title: 'My Todo List'),
    );
  }
}


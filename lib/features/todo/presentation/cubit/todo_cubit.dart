import 'package:bloc/bloc.dart';

import '../../data/model/todo.dart';
import '../../data/repository/todo_repository.dart';
import 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository _todoRepository;

  TodoCubit(this._todoRepository) : super(TodoInitialState());

  void getTodos() async {
    List<Todo> items = await _todoRepository.getTodos();
    emit(TodoLoadedState(items));
  }

  Future<void> search(String keyword) async {
    List<Todo> items = await _todoRepository.search(keyword);
    if (items.isNotEmpty) {
      emit(TodoLoadedState(items));
    } else {
      emit(TodoEmptyState());
    }
  }

  void addTodo(Todo todo) async {
    await _todoRepository.insertTodo(todo);
    getTodos();
  }

  void updateTodo(Todo todo) async {
    await _todoRepository.updateTodo(todo);
    getTodos();
  }

  void deleteTodo(int id) async {
    _todoRepository.deleteTodo(id);
    getTodos();
  }
}

import 'package:equatable/equatable.dart';

import '../../data/model/todo.dart';

abstract class TodoState extends Equatable {}

class TodoInitialState extends TodoState {
  @override
  List<Object?> get props => [];
}

class TodoEmptyState extends TodoState {
  @override
  List<Object?> get props => [];
}

class TodoLoadedState extends TodoState {
  final List<Todo> items;

  TodoLoadedState(this.items);

  @override
  List<Object?> get props => [items];
}

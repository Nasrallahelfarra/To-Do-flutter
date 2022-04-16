import 'package:objectbox/objectbox.dart';

@Entity()
class Todo {
  int id = 0;

  String description;

  bool isDone = false;

  Todo(this.description);
  Todo.create(this.id, this.description);
  @override
  String toString() {
    return 'TodoItem{id: $id, description: $description, isDone: $isDone}';
  }
}

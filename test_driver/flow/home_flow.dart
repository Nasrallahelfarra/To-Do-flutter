import '../steps/home/add_todo_item.dart' as add_todo_item;
import '../steps/home/view_home.dart' as view_home;
import '../steps/home/delete_todo_item.dart' as delete_todo_item;
import '../steps/home/mark_item_as_done..dart' as mark_item_as_done;

Future<void> main() async {
  await view_home.main();
  await add_todo_item.main();
  await mark_item_as_done.main();
  await delete_todo_item.main();
}

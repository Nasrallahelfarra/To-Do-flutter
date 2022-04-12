import '../steps/home/add_to_do_step.dart' as add_to_do_step;
import '../steps/home/view_home_step.dart' as view_home_step;
import '../steps/home/delete_to_do_step.dart' as delete_to_do_step;
import '../steps/home/edite_to_do.dart' as edite_to_do;


Future<void> main() async {
  await view_home_step.main();
  await add_to_do_step.main();
  await edite_to_do.main();
  await delete_to_do_step.main();
}

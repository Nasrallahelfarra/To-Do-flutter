
import '../steps/add_to_do_step.dart' as add_to_do_step;
import '../steps/edite_to_do_step.dart' as edite_to_do_step;
import '../steps/view_home_steps.dart' as view_home_steps;
import '../steps/remove_to_do_step.dart' as remove_to_do_step;

Future <void> main ()async{
  await view_home_steps.main();
  await add_to_do_step.main();
  await edite_to_do_step.main();
  await remove_to_do_step.main();
}
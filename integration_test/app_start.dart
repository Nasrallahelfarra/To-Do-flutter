
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reactive_todo_app/core/object_box/object_box.dart';
import 'package:reactive_todo_app/main.dart';

import 'steps/add_to_do_step.dart';
import 'steps/edite_to_do_step.dart';
import 'steps/remove_to_do_step.dart';
import 'steps/view_home_steps.dart';
import 'package:integration_test/integration_test.dart';

main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  final objectBox = await ObjectBox.create();
  await registerFactories(store: objectBox.store);

  group('TODO :', () {
    testWidgets(
      'App TODO ',
      (WidgetTester tester) async {
        // Initialing Application for Testing and waiting for it to launch
        await tester.pumpWidget(MyApp());
        await tester.pumpAndSettle(Duration(seconds: 3));
        ViewHomeSteps viewHomeSteps=ViewHomeSteps(tester);
        AddToDo addToDo=AddToDo(tester);
        EditToDo editToDo=EditToDo(tester);
        RemoveToDo removeToDo=RemoveToDo(tester);
        await viewHomeSteps.main();
        await addToDo.main();
        await editToDo.main();
        await removeToDo.main();
      },
     /* skip: false,
      timeout: const Timeout(Duration(minutes: 5)),*/
    );
  });
}

import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test/test.dart';

import '../pom/home_pom.dart';
import '../utilities.dart';

class ViewHomeSteps {
  WidgetTester tester;

  ViewHomeSteps(this.tester);
  Future<void> main() async {
    tester.printToConsole('Verify the existence of "menu icon"  ');
    await Utilities.waitForElement(HomePom.getMenuIcon(), tester,
        testCaseId: 3701);

    tester.printToConsole('Verify the existence of "Search icon"  ');
    await Utilities.isPresented(HomePom.getErorrMenuIcon(), tester,
        testCaseId: 3702);

    tester.printToConsole('Verify the existence of "add To do" Button ');
    await Utilities.isPresented(HomePom.getAddButton(), tester,
        testCaseId: 3703);

    tester.printToConsole('Verify the existence of "Name App" text ');
    await Utilities.isPresented(HomePom.getNameTodoText(), tester,
        testCaseId: 3704);
  }
}

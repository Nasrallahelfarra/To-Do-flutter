import 'package:flutter_test/flutter_test.dart';

import '../pom/home_pom.dart';
import '../utilities.dart';

class AddToDo {
  WidgetTester tester;

  AddToDo(this.tester);

  Future<void> main() async {
    tester.printToConsole("end to end tests Add To do Home Page");
    tester.printToConsole("press add to do lead button sheet add to do ");

    await Utilities.tap(HomePom.getAddButton(),tester, testCaseId: 3705);
    await Utilities.waitForElement(HomePom.getTodoTextFiled(),tester,
        testCaseId: 3705);

    tester.printToConsole('Verify the existence of "To Do  TextFiled"  ');
      await Utilities.isPresented(HomePom.getTodoTextFiled(),tester, testCaseId: 3706);


    tester.printToConsole('Verify the existence of "Save icon"  ');
      await Utilities.isPresented(HomePom.getSaveIcon(),tester, testCaseId: 3707);

    tester.printToConsole('Fill to do Text Filed ');
      await Utilities.fillTextThenWait(
          HomePom.getTodoTextFiled(), "example Todo ",tester,
          testCaseId: 3708);

    tester.printToConsole('press Save To do lead  to do Home ');
      await Utilities.tap(HomePom.getSaveIcon(),tester, testCaseId: 3709);
      await Utilities.waitForElementAbsent(HomePom.getTodoTextFiled(),tester,
          testCaseId: 3709);
      await Utilities.waitForElement(HomePom.getTitleTodoText(),tester,
          testCaseId: 3709);

  }
}

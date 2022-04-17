import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../pom/home_pom.dart';
import '../utilities.dart';

class Clada{

}
Future <void> main() async {
  group("end to end tests Add To do Home Page", ()
  {
    test('press add to do lead button sheet add to do "  ', () async {
      await Utilities.tap(HomePom.getAddButton(),testCaseId: 3705);
      await Utilities.waitForElement(HomePom.getTodoTextFiled(),testCaseId: 3705);

    });
    test('Verify the existence of "To Do  TextFiled"  ', () async {
      await Utilities.isPresented(HomePom.getTodoTextFiled(),testCaseId: 3706);
    });

    test('Verify the existence of "Save icon"  ', () async {
      await Utilities.isPresented(HomePom.getSaveIcon(),testCaseId: 3707);
    });
    test('Fill to do Text Filed ', () async {
      await Utilities.fillTextThenWait(HomePom.getTodoTextFiled(),"example Todo ",testCaseId: 3708	);
    });
    test('press Save To do lead  to do Home ', () async {
      await Utilities.tap(HomePom.getSaveIcon(),testCaseId: 3709);
      await Utilities.waitForElementAbsent(HomePom.getTodoTextFiled(),testCaseId: 3709);
      await Utilities.waitForElement(HomePom.getTitleTodoText(),testCaseId: 3709);
    });

  });
}
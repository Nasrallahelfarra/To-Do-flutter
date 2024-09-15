import 'package:flutter_test/flutter_test.dart';

import '../pom/home_pom.dart';
import '../utilities.dart';

class RemoveToDo {
  WidgetTester tester;

  RemoveToDo(this.tester);

  Future<void> main() async {
    tester.printToConsole(
      'press remove Icon lead Hide to Do',
    );
    await Utilities.tap(HomePom.getRemoveIcon(), tester, testCaseId: 3710);
    await Utilities.waitForElementAbsent(HomePom.getRemoveIcon(), tester,
        testCaseId: 3710);
  }
}

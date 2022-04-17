import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../pom/home_pom.dart';
import '../utilities.dart';


Future <void> main() async {
  group("end to end tests edite To do Home Page", ()
  {
    test('Verify title Text To do"  ', () async {
      await Utilities.waitForElement(HomePom.getTitleTodoText(),testCaseId: 3711);
    });
    test('Verify check box To do"', () async {
      await Utilities.isPresented(HomePom.getUnSelectCheckBox(),testCaseId: 3712);
    });
    test('Verify remove Icon To do"', () async {
      await Utilities.isPresented(HomePom.getRemoveIcon(),testCaseId: 3713);
    });
    test('press unCheckBox lead select checkBox', () async {
      await Utilities.tap(HomePom.getUnSelectCheckBox(),testCaseId: 3714);
      await Utilities.waitForElement(HomePom.getSelectCheckBox(),testCaseId: 3714);
    });

  });
}
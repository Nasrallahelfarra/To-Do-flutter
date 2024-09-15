import 'package:flutter_test/flutter_test.dart';

import '../pom/home_pom.dart';
import '../utilities.dart';

class EditToDo{
  WidgetTester tester;

  EditToDo(this.tester);

Future <void> main() async {

    tester.printToConsole('Verify title Text To do"  ');
      await Utilities.waitForElement(HomePom.getTitleTodoText(),tester,testCaseId: 3711);

    tester.printToConsole('Verify check box To do"') ;

      await Utilities.isPresented(HomePom.getUnSelectCheckBox(),tester,testCaseId: 3712);
    tester.printToConsole('Verify remove Icon To do"');
      await Utilities.isPresented(HomePom.getRemoveIcon(),tester,testCaseId: 3713);

    tester.printToConsole('press unCheckBox lead select checkBox');
      await Utilities.tap(HomePom.getUnSelectCheckBox(),tester,testCaseId: 3714);
      await Utilities.waitForElement(HomePom.getSelectCheckBox(),tester,testCaseId: 3714);



}
}
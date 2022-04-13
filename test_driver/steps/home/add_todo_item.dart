import 'dart:io';
import 'package:test/test.dart';
import '../../pom/home_pom.dart';
import '../../utilities.dart';

Future<void> main() async {
  group("end to end tests Add To do", () {
    test(
        'Verify that pressing on "Add To Do" button leads to open "BottomSheet Add To Do',
        () async {
      await Utilities.tap(HomePom.getAddButton());
      await Utilities.waitForElement(HomePom.getAddToDoTextFiled());
    });
    test('Verify the existence of "Add ToDo  " TextFiled', () async {
      await Utilities.isPresented(HomePom.getAddToDoTextFiled());
    });
    test('Verify the existence of "Save " Icon', () async {
      await Utilities.isPresented(HomePom.getSaveIcon());
    });
    test(' fill Add To Do TestFiled', () async {
      await Utilities.fillTextThenWait(
          HomePom.getAddToDoTextFiled(), 'Example To Do ');
    });
    test('Verify that pressing on "Save" icon leads to Add to Do To home',
        () async {
      await Utilities.tap(HomePom.getSaveIcon());
      await Utilities.waitForElementAbsent(HomePom.getSaveIcon());
      await Utilities.waitForElement(HomePom.getTitleTodoText());
    });
    test('Verify the existence of "Title Todo " text filed', () async {
      await Utilities.isPresented(HomePom.getTitleTodoText());
    });
    test('Verify the existence of "Checkbox Todo "  filed', () async {
      await Utilities.isPresented(HomePom.getToDoUnSelectCheckbox());
    });
    test('Verify the existence of "remove icon "  filed', () async {
      await Utilities.isPresented(HomePom.getRemoveIcon());
      sleep(Duration(seconds: 2));
    });
  });
}

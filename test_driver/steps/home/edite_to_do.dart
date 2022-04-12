import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../../pom/home_pom.dart';
import '../../utilities.dart';

Future<void> main() async {
  group("end to end tests Add To do", () {

    test('Verify that pressing on "Checkbox"  leads to finish To do', () async {
      sleep(Duration(seconds: 2));
      await Utilities.tap(HomePom.getToDoUnSelectCheckbox());
      await Utilities.waitForElement(HomePom.getToDoSelectCheckbox());
    });

  });
}

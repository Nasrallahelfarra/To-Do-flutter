import 'dart:io';
import 'package:test/test.dart';
import '../../pom/home_pom.dart';
import '../../utilities.dart';

Future<void> main() async {
  group("end to end tests Add To do", () {
    test('Verify that pressing on "Remove" icon leads to Hide To do', () async {
      sleep(Duration(seconds: 2));
      await Utilities.tap(HomePom.getRemoveIcon());
      await Utilities.waitForElementAbsent(HomePom.getRemoveIcon());
    });
  });
}

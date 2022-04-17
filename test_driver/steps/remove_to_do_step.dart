import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../pom/home_pom.dart';
import '../utilities.dart';


Future <void> main() async {
  group("end to end tests remove To do", ()
  {

    test('press remove Icon lead Hide to Do', () async {
      await Utilities.tap(HomePom.getRemoveIcon(),testCaseId: 3710	);
      await Utilities.waitForElementAbsent(HomePom.getRemoveIcon(),testCaseId: 3710	);
    });

  });
}
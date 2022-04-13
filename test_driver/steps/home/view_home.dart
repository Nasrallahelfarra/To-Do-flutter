import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../../pom/home_pom.dart';
import '../../utilities.dart';

Future<void> main() async {
  group("end to end tests Home Page", () {
    setUpAll(() async {
      await Utilities.setupAndGetDriver();
    });

    test('Driver Health Check', () async {
      final health = await Utilities.driver!.checkHealth();
      expect(health.status, HealthStatus.ok);
    });
    test('Verify the existence of "Name App " Text', () async {
      await Utilities.driver!.clearTimeline();

      await Utilities.waitForElement(HomePom.getNameAppText());
    });
    test('Verify the existence of "Add " Button', () async {
        await Utilities.isPresented(HomePom.getAddButton());
      });
    test('Verify the existence of "Search " Icon', () async {
      await Utilities.isPresented(HomePom.getSearchIcon());
    });
    test('Verify the existence of "menu " Icon', () async {
      await Utilities.isPresented(HomePom.getMenuIcon());
    });

  });
}

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import '../pom/home_pom.dart';
import '../utilities.dart';


Future <void> main() async {
  group("end to end tests View Home Page", ()
  {
    setUpAll(() async {
      await Utilities.setupAndGetDriver();
    });
    test('Driver Health Check', () async {
      final health = await Utilities.driver!.checkHealth();
      expect(health.status, HealthStatus.ok);
    });
    test('Verify the existence of "menu icon"  ', () async {

        await Utilities.waitForElement(HomePom.getMenuIcon(),testCaseId: 3701);
      });
    test('Verify the existence of "Search icon"  ', () async {
      await Utilities.isPresented(HomePom.getErorrMenuIcon(),testCaseId: 3702);
    });
    test('Verify the existence of "add To do" Button ', () async {
      await Utilities.isPresented(HomePom.getAddButton(),testCaseId: 3703);
    });
    test('Verify the existence of "Name App" text ', () async {
      await Utilities.isPresented(HomePom.getNameTodoText(),testCaseId: 3704);
    });

  });
}
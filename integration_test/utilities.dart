import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:test_rail_dart/test_rail.dart';
import 'package:test_rail_dart/test_run.dart';

class Utilities {
  static late TestRun newRun;
  static int passed = 1;
  static int failed = 5;
  static Future<void> setupAndGetDriver() async {

  }
  static Future<void> closeDriver() async {
    sleep(const Duration(seconds: 5));
  }
  static Future<void> testRailInitialize() async {
    TestRail.configure(
        username: 'xxxxxxx@gmail.com',
        password: 'mypassword',
        serverDomain: 'https://yourcompany.testrail.io/');
    //Create test run
    await createTestRun();
  }
  static  Future<void> createTestRun()async {
    newRun = await TestRun.create(
        name: '${DateTime.now().toIso8601String()} Test Run To Do', projectId:3);
    //Add cases to the run
    await newRun.update(
      caseIds: [
        3701,
        3702,
        3703,
        3704,
        3711,
        3712,
        3713,
        3705,
        3706,
        3707,
        3708,
        3709,
        3710,
        3714,
      ],
    );
  }
  static Future<void> requestData(String element) async {
  }
  static Future <void>setTestStatus(int idTestCase, int statusId) async {
   /* await newRun.addResultForCase(
      idTestCase,
      statusId: statusId,
    );*/
  }
  static Future<void> tap(Finder element,WidgetTester tester,{required int testCaseId}) async {
    try {
      await tester.tap(element);
      await tester.pumpAndSettle();
      await tester.pump(Duration(seconds: 2));
      await setTestStatus(testCaseId, passed);

    } on TimeoutException catch(e) {
      await setTestStatus(testCaseId, failed);

    } catch (e) {
      await setTestStatus(testCaseId, failed);

    }
  }
  /*static Future<void> verifyElementText(Finder element, String text,{required int testCaseId}) async {
    String actual = await driver!.getText(element);
    try {
      expect(actual, text);
      await setTestStatus(testCaseId, passed);
    } on TimeoutException catch(e) {
      await setTestStatus(testCaseId, failed);

    } catch (e) {
      await setTestStatus(testCaseId, failed);

    }
  }*/

/*  static Future<String> getText(Finder element,{required int testCaseId}) async {
    String actual = await driver!.getText(element);
    return actual;
  }*/
  static Future<void> waitForElement(Finder element,WidgetTester tester,{required int testCaseId}) async {
    try {
      await tester.pump(Duration(seconds: 5));
      await tester.pumpAndSettle();
      expect(element, findsOneWidget);

      // Verify the counter increments by 1.
      await setTestStatus(testCaseId, passed);

    } on TimeoutException catch(e) {
      print('Test Fail');
      await setTestStatus(testCaseId, failed);
    } catch (e) {
      await setTestStatus(testCaseId, failed);

    }
  }


  static Future<void> fillTextThenWait(Finder element, String text,WidgetTester tester,
      {required int testCaseId}  ) async {
    try {
      await  tester.enterText(element, text);
      expect(find.text(text), findsOneWidget);
      await setTestStatus(testCaseId, passed);

    } on TimeoutException catch(e) {
      await setTestStatus(testCaseId, failed);

    } catch (e) {
      await setTestStatus(testCaseId, failed);

    }
  }


  static Future<void> waitForElementAbsent(Finder element,WidgetTester tester,{required int testCaseId}) async {
    try {
      await tester.pump(Duration(seconds: 2));
      await tester.pumpAndSettle();
      expect(element, findsNothing);
      await setTestStatus(testCaseId, passed);
    } on TimeoutException catch(e) {
      await setTestStatus(testCaseId, failed);

    } catch (e) {
      await setTestStatus(testCaseId, failed);

    }
  }

  static Future<void> isPresented(Finder element,WidgetTester tester,{required int testCaseId}
      ) async {
    try {
      expect(await Utilities.isPresent(element,tester,testCaseId:testCaseId ), true);
      await setTestStatus(testCaseId, passed);

    } on TimeoutException catch(e) {
      await setTestStatus(testCaseId, failed);

    } catch (e) {
      await setTestStatus(testCaseId, failed);

    }

  }
  static Future<bool> isPresent(Finder finder,WidgetTester tester,
      {Duration timeout = const Duration(seconds: 5),required int testCaseId}) async {
    Stopwatch s = Stopwatch();
    s.start();
    try {
      await tester.pump(timeout);
      expect(finder, findsOneWidget);
      await tester.pumpAndSettle();
      await setTestStatus(testCaseId, passed);

    } on TimeoutException catch(e) {
      await setTestStatus(testCaseId, failed);

    } catch (e) {
      await setTestStatus(testCaseId, failed);

    }
    s.stop();
    if (s.elapsedMilliseconds >= timeout.inMilliseconds) {
      return false;
    } else {
      return true;
    }
  }

}

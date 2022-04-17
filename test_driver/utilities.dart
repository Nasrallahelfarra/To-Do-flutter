import 'dart:async';
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:test_rail_dart/test_rail.dart';
import 'package:test_rail_dart/test_run.dart';

class Utilities {
  static FlutterDriver? driver;
  static late TestRun newRun;
  static int passed = 1;
  static int failed = 5;
  static Future<void> setupAndGetDriver() async {
    driver = await FlutterDriver.connect();
    await testRailInitialize();
    var connected = false;
    while (!connected) {
      try {
        await driver!.waitUntilFirstFrameRasterized();
        connected = true;
      } on TimeoutException {
      } catch (error) {

      }
    }
  }
  static Future<void> closeDriver() async {
    sleep(const Duration(seconds: 5));
    if (driver != null) driver!.close();
  }
  static Future<void> testRailInitialize() async {
    TestRail.configure(
        username: 'isharif@famcare.app',
        password: '7vFp6ETyOf1XJXnXk3vQ',
        serverDomain: 'https://famcare.testrail.io/');
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
    await driver!.requestData(element);
  }
  static Future <void>setTestStatus(int idTestCase, int statusId) async {
    await newRun.addResultForCase(
      idTestCase,
      statusId: statusId,
    );
  }
  static Future<void> tap(SerializableFinder element,{required int testCaseId}) async {
    try {
      await driver!.tap(element);
      await setTestStatus(testCaseId, passed);

    } on TimeoutException catch(e) {
      await setTestStatus(testCaseId, failed);

    } catch (e) {
      await setTestStatus(testCaseId, failed);

    }
  }
  static Future<void> verifyElementText(SerializableFinder element, String text,{required int testCaseId}) async {
    String actual = await driver!.getText(element);
    try {
      expect(actual, text);
      await setTestStatus(testCaseId, passed);
    } on TimeoutException catch(e) {
      await setTestStatus(testCaseId, failed);

    } catch (e) {
      await setTestStatus(testCaseId, failed);

    }
  }

  static Future<String> getText(SerializableFinder element,{required int testCaseId}) async {
    String actual = await driver!.getText(element);
    return actual;
  }
  static Future<void> waitForElement(SerializableFinder element,{required int testCaseId}) async {
    try {
      await driver!.waitFor(element);
      await setTestStatus(testCaseId, passed);

    } on TimeoutException catch(e) {
      print('Test Fail');
      await setTestStatus(testCaseId, failed);
    } catch (e) {
      await setTestStatus(testCaseId, failed);

    }
  }


  static Future<void> fillTextThenWait(SerializableFinder element, String text,
      {required int testCaseId}  ) async {
    try {
      await driver!.tap(element);
      await driver!.enterText(text.trim());
      await driver!.waitFor(find.text(text.trim()));
      await setTestStatus(testCaseId, passed);

    } on TimeoutException catch(e) {
      await setTestStatus(testCaseId, failed);

    } catch (e) {
      await setTestStatus(testCaseId, failed);

    }
  }


  static Future<void> waitForElementAbsent(SerializableFinder element,{required int testCaseId}) async {
    try {
      await driver!.waitForAbsent(element);
      await setTestStatus(testCaseId, passed);
    } on TimeoutException catch(e) {
      await setTestStatus(testCaseId, failed);

    } catch (e) {
      await setTestStatus(testCaseId, failed);

    }
  }

  static Future<void> isPresented(SerializableFinder element,{required int testCaseId}
      ) async {
    try {
      expect(await Utilities.isPresent(element,testCaseId:testCaseId ), true);
      await setTestStatus(testCaseId, passed);

    } on TimeoutException catch(e) {
      await setTestStatus(testCaseId, failed);

    } catch (e) {
      await setTestStatus(testCaseId, failed);

    }

  }
  static Future<bool> isPresent(SerializableFinder finder,
      {Duration timeout = const Duration(seconds: 5),required int testCaseId}) async {
    Stopwatch s = Stopwatch();
    s.start();
    try {
      await driver!.waitFor(finder, timeout: timeout);
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
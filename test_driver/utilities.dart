import 'dart:async';
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

class Utilities {
  static FlutterDriver? driver;
  static Future<void> setupAndGetDriver() async {
    driver = await FlutterDriver.connect();
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

  static Future<void> requestData(String element) async {
    await driver!.requestData(element);
  }

  static Future<void> tap(SerializableFinder element) async {
    try {
      await driver!.tap(element);
    } on TimeoutException {
    } catch (e) {
    }
  }
  static Future<void> verifyElementText(SerializableFinder element, String text,) async {
    String actual = await driver!.getText(element);
    try {
      expect(actual, text);
    } on TimeoutException {
    } catch (e) {
    }
  }

  static Future<String> getText(SerializableFinder element) async {
    String actual = await driver!.getText(element);
    return actual;
  }
  static Future<void> waitForElement(SerializableFinder element) async {
    try {
      await driver!.waitFor(element);
    } on TimeoutException {
    } catch (e) {
    }
  }


  static Future<void> fillTextThenWait(SerializableFinder element, String text,
     ) async {
    try {
      await driver!.tap(element);
      await driver!.enterText(text.trim());
      await driver!.waitFor(find.text(text.trim()));
    } on TimeoutException {
    } catch (e) {
    }
  }


  static Future<void> waitForElementAbsent(SerializableFinder element,) async {
    try {
      await driver!.waitForAbsent(element);
    } on TimeoutException {
    } catch (e) {
    }
  }

  static Future<void> isPresented(SerializableFinder element,
   ) async {
    expect(await Utilities.isPresent(element), true);
  }
  static Future<bool> isPresent(SerializableFinder finder,
      {Duration timeout = const Duration(seconds: 5),}) async {
    Stopwatch s = Stopwatch();
    s.start();
    try {
      await driver!.waitFor(finder, timeout: timeout);

    } on TimeoutException {

    } catch (e) {

    }
    s.stop();
    if (s.elapsedMilliseconds >= timeout.inMilliseconds) {
      return false;
    } else {
      return true;
    }
  }

}
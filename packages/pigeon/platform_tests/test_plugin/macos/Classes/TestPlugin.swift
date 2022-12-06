// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import Cocoa
import FlutterMacOS

/**
 * This plugin handles the native side of the integration tests in
 * example/integration_test/.
 */
public class TestPlugin: NSObject, FlutterPlugin, HostIntegrationCoreApi {
  var flutterAPI: FlutterIntegrationCoreApi

  public static func register(with registrar: FlutterPluginRegistrar) {
    let plugin = TestPlugin(binaryMessenger: registrar.messenger)
    HostIntegrationCoreApiSetup.setUp(binaryMessenger: registrar.messenger, api: plugin)
  }

  init(binaryMessenger: FlutterBinaryMessenger) {
    flutterAPI = FlutterIntegrationCoreApi(binaryMessenger: binaryMessenger)
  }

  // MARK: HostIntegrationCoreApi implementation

  func noop() {
  }

  func echoAllTypes(everything: AllTypes) -> AllTypes {
    return everything
  }

  func throwError() {
    // TODO(stuartmorgan): Implement this. See
    // https://github.com/flutter/flutter/issues/112483
  }

  func extractNestedString(wrapper: AllTypesWrapper) -> String? {
    return wrapper.values.aString;
  }

  func createNestedString(string: String) -> AllTypesWrapper {
    return AllTypesWrapper(values: AllTypes(aString: string))
  }

  func noopAsync(completion: @escaping () -> Void) {
    completion()
  }

  func echoAsyncString(aString: String, completion: @escaping (String) -> Void) {
    completion(aString)
  }

  func callFlutterNoop(completion: @escaping () -> Void) {
    flutterAPI.noop() {
      completion()
    }
  }

  func callFlutterEchoString(aString: String, completion: @escaping (String) -> Void) {
    flutterAPI.echoString(aString: aString) { flutterString in
      completion(flutterString)
    }
  }
}

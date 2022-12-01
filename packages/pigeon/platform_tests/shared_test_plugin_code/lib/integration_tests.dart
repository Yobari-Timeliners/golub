// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// TODO(a14n): remove this import once Flutter 3.1 or later reaches stable (including flutter/flutter#104231)
// ignore: unnecessary_import
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'generated.dart';

/// Sets up and runs the integration tests.
void runPigeonIntegrationTests() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Host API tests', () {
    testWidgets('voidCallVoidReturn', (WidgetTester _) async {
      final HostIntegrationCoreApi api = HostIntegrationCoreApi();

      expect(api.noop(), completes);
    });

    testWidgets('allDataTypesEcho', (WidgetTester _) async {
      final HostIntegrationCoreApi api = HostIntegrationCoreApi();

      final AllTypes sentObject = AllTypes(
        aBool: true,
        anInt: 42,
        aDouble: 3.14159,
        aString: 'Hello host!',
        aByteArray: Uint8List.fromList(<int>[1, 2, 3]),
        a4ByteArray: Int32List.fromList(<int>[4, 5, 6]),
        a8ByteArray: Int64List.fromList(<int>[7, 8, 9]),
        aFloatArray: Float64List.fromList(<double>[2.71828, 3.14159]),
        aList: <Object?>['Thing 1', 2],
        aMap: <Object?, Object?>{'a': 1, 'b': 2.0},
        nestedList: <List<bool>>[
          <bool>[true, false],
          <bool>[false, true]
        ],
      );

      final AllTypes echoObject = await api.echoAllTypes(sentObject);
      expect(echoObject.aBool, sentObject.aBool);
      expect(echoObject.anInt, sentObject.anInt);
      expect(echoObject.aDouble, sentObject.aDouble);
      expect(echoObject.aString, sentObject.aString);
      // TODO(stuartmorgan): Enable these once they work for all generators;
      // currently at least Swift is broken.
      // See https://github.com/flutter/flutter/issues/115906
      //expect(echoObject.aByteArray, sentObject.aByteArray);
      //expect(echoObject.a4ByteArray, sentObject.a4ByteArray);
      //expect(echoObject.a8ByteArray, sentObject.a8ByteArray);
      //expect(echoObject.aFloatArray, sentObject.aFloatArray);
      expect(listEquals(echoObject.aList, sentObject.aList), true);
      expect(mapEquals(echoObject.aMap, sentObject.aMap), true);
      expect(echoObject.nestedList?.length, sentObject.nestedList?.length);
      // TODO(stuartmorgan): Enable this once the Dart types are fixed; see
      // https://github.com/flutter/flutter/issues/116117
      //for (int i = 0; i < echoObject.nestedList!.length; i++) {
      //  expect(listEquals(echoObject.nestedList![i], sentObject.nestedList![i]),
      //      true);
      //}
      expect(
          mapEquals(
              echoObject.mapWithAnnotations, sentObject.mapWithAnnotations),
          true);
      expect(
          mapEquals(echoObject.mapWithObject, sentObject.mapWithObject), true);
    });
  });

  group('Flutter API tests', () {
    // TODO(stuartmorgan): Add Flutter API tests, driven by wrapper host APIs
    // that forward the arguments and return values in the opposite direction.
  });
}

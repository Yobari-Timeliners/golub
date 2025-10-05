// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:golub/src/generator_tools.dart';
import 'package:test/test.dart';

void main() {
  test('golub version matches pubspec', () {
    final String pubspecPath = '${Directory.current.path}/pubspec.yaml';
    final String pubspec = File(pubspecPath).readAsStringSync();
    final RegExp regex = RegExp(r'version:\s*(.*?) #');
    final RegExpMatch? match = regex.firstMatch(pubspec);
    expect(match, isNotNull);
    expect(
      golubVersion,
      match?.group(1)?.trim(),
      reason:
          'Update lib/src/generator_tools.dart golubVersion to the value in the pubspec',
    );
  });
}

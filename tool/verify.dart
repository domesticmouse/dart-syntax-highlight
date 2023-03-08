// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:json_schema2/json_schema2.dart';

void main() async {
  final schema = await JsonSchema.createSchemaAsync(
      await File('third_party/tmlanguage/tmlanguage.json').readAsString(),
      schemaVersion: SchemaVersion.draft4);

  // Validate the grammars/dart.json file.
  File grammarFile = File('grammars/dart.json');

  try {
    final grammar = grammarFile.readAsStringSync();
    jsonDecode(grammar);
    schema.validate(grammar);
    print('${grammarFile.path} ok.');
    exit(0);
  } catch (e) {
    print('Error parsing ${grammarFile.path}: $e');
    exit(1);
  }
}

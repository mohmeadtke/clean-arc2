import 'dart:io';

String fixture (String name) {
  return File('test/core/fixture/$name').readAsStringSync();
}
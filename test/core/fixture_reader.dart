import 'dart:io';

String fixture (String name) {
  return File('test/core/$name').readAsStringSync();
}
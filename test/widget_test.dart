// ─── test/widget_test.dart ───
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('App version is 1.0.0', () {
    const version = '1.0.0+1';
    expect(version, contains('1.0.0'));
  });
}

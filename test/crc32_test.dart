library crc32_test;

import 'package:crc32/crc32.dart';
import 'package:test/test.dart';

void main() {
  group("String", () {
    test('empty', () {
      expect(CRC32.compute(""), 0);
    });

    test('simple', () {
      expect(CRC32.compute('hello').toRadixString(16), '3610a686');
    });

    test('crc32 is positive', () {
      expect(CRC32.compute('HELLO'), 3242484790);
    });

    test('utf8 encoding', () {
      expect(CRC32.compute('\u{1F336}').toRadixString(16), 'e459f788');
    });
  });

  group("List<int>", () {
    test('empty', () {
      expect(CRC32.compute(<int>[]), 0);
    });

    test('simple', () {
      expect(CRC32.compute('hello'.codeUnits).toRadixString(16), '3610a686');
    });

    test('boundaries', () {
      expect(CRC32.compute(<int>[-127, 0, 255]), 850675496);
    });
  });

  group("Exceptions", () {
    test('null input', () {
      expect(() => CRC32.compute(null), throwsArgumentError);
    });

    test('256', () {
      expect(() => CRC32.compute(<int>[256]), throwsFormatException);
    });

    test('-129', () {
      expect(() => CRC32.compute(<int>[-129]), throwsFormatException);
    });
  });
}

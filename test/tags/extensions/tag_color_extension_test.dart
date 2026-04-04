import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/tags/extensions/tag_color_extension.dart';
import 'package:tag_repository/tag_repository.dart';

void main() {
  group('TagColorX.toColor', () {
    test('red maps to Colors.red', () {
      expect(TagColor.red.toColor(), Colors.red);
    });

    test('crimson maps to Colors.red.shade800', () {
      expect(TagColor.crimson.toColor(), Colors.red.shade800);
    });

    test('orange maps to Colors.orange', () {
      expect(TagColor.orange.toColor(), Colors.orange);
    });

    test('deepOrange maps to Colors.deepOrange', () {
      expect(TagColor.deepOrange.toColor(), Colors.deepOrange);
    });

    test('amber maps to Colors.amber', () {
      expect(TagColor.amber.toColor(), Colors.amber);
    });

    test('yellow maps to Colors.yellow', () {
      expect(TagColor.yellow.toColor(), Colors.yellow);
    });

    test('lime maps to Colors.lime', () {
      expect(TagColor.lime.toColor(), Colors.lime);
    });

    test('green maps to Colors.green', () {
      expect(TagColor.green.toColor(), Colors.green);
    });

    test('lightGreen maps to Colors.lightGreen', () {
      expect(TagColor.lightGreen.toColor(), Colors.lightGreen);
    });

    test('emerald maps to Colors.green.shade700', () {
      expect(TagColor.emerald.toColor(), Colors.green.shade700);
    });

    test('blue maps to Colors.blue', () {
      expect(TagColor.blue.toColor(), Colors.blue);
    });

    test('lightBlue maps to Colors.lightBlue', () {
      expect(TagColor.lightBlue.toColor(), Colors.lightBlue);
    });

    test('indigo maps to Colors.indigo', () {
      expect(TagColor.indigo.toColor(), Colors.indigo);
    });

    test('navy maps to a specific Color', () {
      expect(
        TagColor.navy.toColor(),
        const Color.fromARGB(255, 23, 116, 255),
      );
    });

    test('cyan maps to Colors.cyan', () {
      expect(TagColor.cyan.toColor(), Colors.cyan);
    });

    test('teal maps to Colors.teal', () {
      expect(TagColor.teal.toColor(), Colors.teal);
    });

    test('purple maps to Colors.purple', () {
      expect(TagColor.purple.toColor(), Colors.purple);
    });

    test('deepPurple maps to Colors.deepPurple', () {
      expect(TagColor.deepPurple.toColor(), Colors.deepPurple);
    });

    test('violet maps to Colors.deepPurple.shade300', () {
      expect(TagColor.violet.toColor(), Colors.deepPurple.shade300);
    });

    test('pink maps to Colors.pink', () {
      expect(TagColor.pink.toColor(), Colors.pink);
    });

    test('rose maps to Colors.pink.shade300', () {
      expect(TagColor.rose.toColor(), Colors.pink.shade300);
    });
  });

  group('TagColorX.fromColor', () {
    test('returns matching TagColor for known color', () {
      expect(TagColorX.fromColor(Colors.red), TagColor.red);
      expect(TagColorX.fromColor(Colors.blue), TagColor.blue);
      expect(TagColorX.fromColor(Colors.green), TagColor.green);
    });

    test('returns TagColor.blue as fallback for unknown color', () {
      expect(
        TagColorX.fromColor(const Color(0xFFDEADBE)),
        TagColor.blue,
      );
    });

    test('roundtrip: toColor → fromColor returns original', () {
      for (final color in TagColor.values) {
        expect(TagColorX.fromColor(color.toColor()), color);
      }
    });
  });
}

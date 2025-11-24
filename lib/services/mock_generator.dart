import 'dart:math';
import 'dart:async';

class MockGenerator {
  static Future<String> generate(String prompt) async {
    await Future.delayed(Duration(seconds: 2 + Random().nextInt(2)));
    if (Random().nextBool()) {
      throw Exception('Mock API failure');
    }
    return 'assets/placeholder.png';
  }
}

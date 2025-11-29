import 'package:flutter/material.dart';

class NumberStream {
  Stream<int> getNumbers() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (int t) {
      int random = t % 10;
      return random;
    });
  }
}

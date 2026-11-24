import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab05_partb/main.dart';

void main() {
  testWidgets('Car table shows the three column headers', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: CarTablePage()));

    expect(find.text('Car Make'), findsOneWidget);
    expect(find.text('Model'), findsOneWidget);
    expect(find.text('Price (RM)'), findsOneWidget);
  });
}
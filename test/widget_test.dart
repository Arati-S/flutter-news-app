import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:newsly/app/app.dart';

void main() {
  testWidgets('App shows login page initially', (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(const App());

    // Expect to find login fields
    expect(find.text('FlashFeed Login'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });
}

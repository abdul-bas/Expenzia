import 'package:flutter_test/flutter_test.dart';

import 'package:expenzia/main.dart';

void main() {
  testWidgets('Expenzia app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ExpenziaApp());

    // Verify that the initial welcome title is present.
    expect(find.text('Welcome to Expenzia'), findsOneWidget);
  });
}

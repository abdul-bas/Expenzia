import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expenzia/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:expenzia/main.dart';

void main() {
  testWidgets('Expenzia smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ExpenziaApp());

    // Verify splash screen brand title is present
    expect(find.text('Expenzia'), findsOneWidget);

    // Build onboarding page directly to test UI
    await tester.pumpWidget(
      MaterialApp(
        home: OnboardingPage(),
      ),
    );

    // Verify Onboarding title & button
    expect(find.text('Spend Smarter\nSave More'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });
}

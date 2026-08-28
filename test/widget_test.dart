import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_100/main.dart';

void main() {
  testWidgets('shows Lifeline donor home screen', (tester) async {
    await tester.pumpWidget(const LifelineApp());
    expect(find.text('Hello, Sara'), findsOneWidget);
    expect(find.text('Your blood can save a life'), findsOneWidget);
  });
}

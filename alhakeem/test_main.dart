import 'package:flutter_test/flutter_test.dart';
import 'package:alhakeem/main.dart';

void main() {
  testWidgets('اختبار واجهة المستخدم', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('مرحبا'), findsOneWidget);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_engineering_sample_app/news_app.dart';

import 'test_service_locator.dart';

void main() {
  group('NewsApp', () {
    setUp(() {
      setUpTestServiceLocator();
    });

    testWidgets('NewsApp screen', (WidgetTester tester) async {
      // Build app and trigger a frame.
      await tester.pumpWidget(const NewsApp());
      await tester.pumpAndSettle();

      // Starts in Home screen
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Favorites'), findsNothing);
    });
  });
}

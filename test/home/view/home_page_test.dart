import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/inventory/view/inventory_page.dart';
import 'package:inventory_app/home/view/home_page.dart';
import 'package:inventory_app/inventory/view/inventory_page.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('HomePage', () {
    testWidgets('shows Inventory tab by default', (tester) async {
      await tester.pumpApp(
        const HomeView(),
      );

      expect(find.byType(InventoryPage), findsOneWidget);
      expect(find.byType(InventoryPage), findsNothing);
    });
  });

  testWidgets('switches to Catalogue tab when tapped', (tester) async {
    await tester.pumpApp(
      const HomeView(),
    );

    await tester.tap(find.text('Catalogue'));
    await tester.pumpAndSettle();

    expect(find.byType(InventoryPage), findsOneWidget);
  });
}

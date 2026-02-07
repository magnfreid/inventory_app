import 'package:inventory_app/app/app.dart';
import 'package:inventory_app/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}

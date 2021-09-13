import 'flavors.dart';
import 'main.dart' as app;

Future<void> main() {
  F.appFlavor = Flavor.PRODUCTION;
  return app.main();
}

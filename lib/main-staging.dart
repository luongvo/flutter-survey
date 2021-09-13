import 'flavors.dart';
import 'main.dart' as app;

Future<void> main() {
  F.appFlavor = Flavor.STAGING;
  return app.main();
}

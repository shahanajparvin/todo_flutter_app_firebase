import 'package:todo_app/core/flavor/flavor_config.dart';
import 'package:todo_app/main_common.dart';

void main() {
  mainCommon(const FlavorConfig(
      flavorType: FlavorType.staging,
      baseUrl: "https://api.pointsafety.getonnet.dev",
      packageName: "com.pointsafetynor.readytolearn.staging"));
}

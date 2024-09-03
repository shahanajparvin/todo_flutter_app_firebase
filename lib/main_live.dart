

import 'package:todo_app/core/flavor/flavor_config.dart';
import 'package:todo_app/main_common.dart';

void main() {
  mainCommon(const FlavorConfig(
      flavorType: FlavorType.live,
      baseUrl: "https://private-2d1535-admindashboard4.apiary-mock.com",
      packageName: "com.pointsafetynor.readytolearn"));
}

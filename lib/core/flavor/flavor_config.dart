


class FlavorConfig {
  final FlavorType flavorType;
  final String baseUrl;
  final String packageName;

  const FlavorConfig({required this.flavorType, required this.baseUrl, required this.packageName});
}

enum FlavorType {
  staging("Staging"), live("Live");

  final String name;

  const FlavorType(this.name);
}
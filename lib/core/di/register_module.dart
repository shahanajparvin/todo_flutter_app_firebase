

/*@module
abstract class RegisterModule {
  @singleton
  DioClient get dioClient {
    final client = DioClient(baseUrl: flavorConfig.baseUrl, connectTimeoutInSeconds: 45000, receiveTimeoutInSeconds: 45000, sendTimeoutInSeconds: 4500);
    final refreshTokenClient = DioClient(baseUrl: flavorConfig.baseUrl, connectTimeoutInSeconds: 45000, receiveTimeoutInSeconds: 45000, sendTimeoutInSeconds: 4500);
    client.addInterceptor(TokenInterceptor(resolver: resolver, refreshTokenClient: refreshTokenClient));
    return client;
  }
}*/
const String environment = String.fromEnvironment('ENV', defaultValue: 'test');

class Config {
  static int get kSecondsInDay => (environment == 'prod') ? 86400 : 60;
}

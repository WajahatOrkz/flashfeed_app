/// Application configuration constants
class AppConfig {
  AppConfig._();

  /// API Base URL - Update this with your actual API endpoint
  static const String apiBaseUrl = 'https://api.example.com';

  /// API timeouts
  static const Duration connectTimeout = Duration(minutes: 5);
  static const Duration receiveTimeout = Duration(minutes: 5);
  static const Duration sendTimeout = Duration(minutes: 5);

  /// Shared Preferences Keys
  static const String tokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String userEmailKey = 'user_email';
  static const String userNameKey = 'user_name';
  static const String isLoggedInKey = 'is_logged_in';

  /// API Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String logoutEndpoint = '/auth/logout';
  static const String profileEndpoint = '/user/profile';

  /// Environment
  static const bool isDevelopment = true;
  static const bool enableApiLogging = true;
}
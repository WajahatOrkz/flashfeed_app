import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing shared preferences
/// Provides type-safe access to stored data
class SharedPreferencesService {
  SharedPreferencesService._();

  static final SharedPreferencesService instance = SharedPreferencesService._();

  late SharedPreferences _prefs;
  bool _initialized = false;

  /// Initialize shared preferences
  /// Call this in main() before running the app
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _initialized = true;
  }

  /// Check if service is initialized
  bool get isInitialized => _initialized;

  // ==================== String Operations ====================

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  // ==================== Int Operations ====================

  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  // ==================== Double Operations ====================

  Future<bool> setDouble(String key, double value) async {
    return await _prefs.setDouble(key, value);
  }

  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  // ==================== Bool Operations ====================

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  // ==================== StringList Operations ====================

  Future<bool> setStringList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  // ==================== Remove & Clear Operations ====================

  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  Future<bool> clear() async {
    return await _prefs.clear();
  }

  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  Set<String> getKeys() {
    return _prefs.getKeys();
  }

  // ==================== Helper Methods ====================

  /// Get auth token
  String? get token => getString('auth_token');

  /// Set auth token
  Future<bool> setToken(String token) => setString('auth_token', token);

  /// Remove auth token
  Future<bool> removeToken() => remove('auth_token');

  /// Check if user is logged in
  bool get isLoggedIn => getBool('is_logged_in') ?? false;

  /// Set login status
  Future<bool> setLoggedIn(bool value) => setBool('is_logged_in', value);

  // ==================== User Session ====================

  /// Save full user session after login/register
  Future<void> saveUserSession({
    required String token,
    required String email,
    required String name,
    String? deviceId,
  }) async {
    await setString('auth_token', token);
    await setString('user_email', email);
    await setString('user_name', name);
    if (deviceId != null) await setString('device_id', deviceId);
    await setBool('is_logged_in', true);
  }

  /// Clear user session on logout
  Future<void> clearUserSession() async {
    await remove('auth_token');
    await remove('user_email');
    await remove('user_name');
    await remove('device_id');
    await setBool('is_logged_in', false);
  }

  String? get userEmail => getString('user_email');
  String? get userName => getString('user_name');
  String? get deviceId => getString('device_id');
}

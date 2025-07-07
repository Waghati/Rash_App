import 'package:flutter/foundation.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  bool _isAuthenticated = false;
  String? _errorMessage;

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  String? get errorMessage => _errorMessage;

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set error message
  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Login method (placeholder - will connect to backend later)
  Future<bool> login(String email, String password, String userType) async {
    _setLoading(true);
    _setError(null);

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // For demo purposes, create a mock user
      if (email.isNotEmpty && password.isNotEmpty) {
        _user = User(
          id: '1',
          email: email,
          name: email.split('@')[0].toUpperCase(),
          type: UserType.values.firstWhere(
                (e) => e.name == userType,
            orElse: () => UserType.student,
          ),
          createdAt: DateTime.now(),
        );
        _isAuthenticated = true;
        _setLoading(false);
        return true;
      } else {
        _setError('Invalid email or password');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError('Login failed: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  // Register method (placeholder)
  Future<bool> register(Map<String, dynamic> userData) async {
    _setLoading(true);
    _setError(null);

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // For demo purposes, create a user from registration data
      final userType = userData['type'] ?? 'student';
      _user = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: userData['email'],
        name: userData['name'],
        type: UserType.values.firstWhere(
              (e) => e.name == userType,
          orElse: () => UserType.student,
        ),
        createdAt: DateTime.now(),
      );
      _isAuthenticated = true;
      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Registration failed: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }

  // Logout method
  Future<void> logout() async {
    _user = null;
    _isAuthenticated = false;
    _errorMessage = null;
    notifyListeners();
  }

  // Check if user is logged in (for app startup)
  Future<void> checkAuthStatus() async {
    _setLoading(true);

    // In a real app, you'd check stored tokens/credentials here
    await Future.delayed(const Duration(seconds: 1));

    _setLoading(false);
  }

  // Update user profile
  Future<bool> updateProfile(Map<String, dynamic> updates) async {
    if (_user == null) return false;

    _setLoading(true);
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Update user data (this would normally come from the API response)
      _user = _user!.copyWith(
        name: updates['name'] ?? _user!.name,
        profileImage: updates['profile_image'] ?? _user!.profileImage,
      );

      _setLoading(false);
      return true;
    } catch (e) {
      _setError('Profile update failed: ${e.toString()}');
      _setLoading(false);
      return false;
    }
  }
}

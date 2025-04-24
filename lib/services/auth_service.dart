import 'package:flutter/material.dart';

enum AuthStatus { initial, authenticated, unauthenticated }

class AuthService extends ChangeNotifier {
  AuthStatus _status = AuthStatus.initial;
  String? _userId;
  String? _email;
  String? _name;
  String? _error;
  String? _profileImage;
  String? _jobTitle;

  // Mock users database
  final List<Map<String, dynamic>> _mockUsers = [
    {
      'id': 'user-001',
      'email': 'ahmed@example.com',
      'password': 'password123',
      'name': 'Ahmed Khalid',
      'profileImage': 'https://randomuser.me/api/portraits/men/32.jpg',
      'jobTitle': 'Senior UI/UX Designer',
    },
    {
      'id': 'user-002',
      'email': 'sarah@example.com',
      'password': 'sarah123',
      'name': 'Sarah Johnson',
      'profileImage': 'https://randomuser.me/api/portraits/women/44.jpg',
      'jobTitle': 'Full Stack Developer',
    },
    {
      'id': 'user-003',
      'email': 'user@example.com',
      'password': 'password',
      'name': 'Test User',
      'profileImage': 'https://randomuser.me/api/portraits/lego/1.jpg',
      'jobTitle': 'Software Engineer',
    },
  ];

  AuthStatus get status => _status;
  String? get userId => _userId;
  String? get email => _email;
  String? get name => _name;
  String? get error => _error;
  String? get profileImage => _profileImage;
  String? get jobTitle => _jobTitle;

  // This is a mock implementation - in a real app, you would connect to a backend
  Future<bool> login(String email, String password) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Find user in mock database
      final user = _mockUsers.firstWhere(
        (user) => user['email'] == email && user['password'] == password,
        orElse: () => {},
      );

      if (user.isNotEmpty) {
        _status = AuthStatus.authenticated;
        _userId = user['id'];
        _email = user['email'];
        _name = user['name'];
        _profileImage = user['profileImage'];
        _jobTitle = user['jobTitle'];
        _error = null;
        notifyListeners();
        return true;
      } else {
        // For demo purposes, also accept any email with a password longer than 5 chars
        if (password.length > 5) {
          _status = AuthStatus.authenticated;
          _userId = 'user-${DateTime.now().millisecondsSinceEpoch}';
          _email = email;
          _name = email.split('@').first;
          _profileImage = 'https://randomuser.me/api/portraits/lego/6.jpg';
          _jobTitle = 'New User';
          _error = null;
          notifyListeners();
          return true;
        } else {
          _error = 'Invalid credentials';
          notifyListeners();
          return false;
        }
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Check if email already exists
      final existingUser = _mockUsers.firstWhere(
        (user) => user['email'] == email,
        orElse: () => {},
      );

      if (existingUser.isNotEmpty) {
        _error = 'Email already registered';
        notifyListeners();
        return false;
      }

      // For demo purposes, accept any registration with valid inputs
      if (name.isNotEmpty && email.contains('@') && password.length > 5) {
        final userId = 'user-${DateTime.now().millisecondsSinceEpoch}';

        // In a real app, you would save this to a database
        // Here we're just setting the current user
        _status = AuthStatus.authenticated;
        _userId = userId;
        _email = email;
        _name = name;
        _profileImage = 'https://randomuser.me/api/portraits/lego/5.jpg';
        _jobTitle = 'New Member';
        _error = null;
        notifyListeners();
        return true;
      } else {
        _error = 'Invalid registration data';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> loginWithGoogle() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock Google user
      _status = AuthStatus.authenticated;
      _userId = 'google-user-123';
      _email = 'google.user@example.com';
      _name = 'Google User';
      _profileImage = 'https://randomuser.me/api/portraits/men/85.jpg';
      _jobTitle = 'Product Manager';
      _error = null;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> loginWithFacebook() async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock Facebook user
      _status = AuthStatus.authenticated;
      _userId = 'facebook-user-123';
      _email = 'facebook.user@example.com';
      _name = 'Facebook User';
      _profileImage = 'https://randomuser.me/api/portraits/women/65.jpg';
      _jobTitle = 'Marketing Specialist';
      _error = null;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // For demo purposes, always succeed
      _error = null;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    _status = AuthStatus.unauthenticated;
    _userId = null;
    _email = null;
    _name = null;
    _profileImage = null;
    _jobTitle = null;
    _error = null;
    notifyListeners();
  }

  // Check if user is logged in (e.g., on app start)
  Future<void> checkAuthStatus({bool autoLogin = false}) async {
    // Simulate checking stored credentials
    await Future.delayed(const Duration(milliseconds: 500));

    // For demo purposes, you can pass autoLogin=true to start as authenticated
    // with a default user, or autoLogin=false to start as unauthenticated
    if (autoLogin) {
      // Use the first mock user as the default logged-in user
      final defaultUser = _mockUsers.first;
      _status = AuthStatus.authenticated;
      _userId = defaultUser['id'];
      _email = defaultUser['email'];
      _name = defaultUser['name'];
      _profileImage = defaultUser['profileImage'];
      _jobTitle = defaultUser['jobTitle'];
    } else {
      _status = AuthStatus.unauthenticated;
    }

    notifyListeners();
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class AuthNotifier extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    
    if (token != null) {
      try {
        return await ApiService().getMe();
      } catch (e) {
        // Token might be invalid or expired
        await logout();
        return null;
      }
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final (user, token) = await ApiService().login(email, password);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      return user;
    });
  }

  Future<void> register(String name, String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final (user, token) = await ApiService().register(name, email, password);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      return user;
    });
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    state = const AsyncData(null);
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, User?>(AuthNotifier.new);

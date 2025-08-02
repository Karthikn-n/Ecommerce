import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:e_commerce/data/error/exception_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final _supabase = Supabase.instance.client;


  Future<void> signUpWithDetails({
    required String email,
    required String password,
    required String name,
  }) async {
    // Sign up with email/password
    try {
      final existing = await _supabase
        .from('users')
        .select()
        .eq('email', email)
        .maybeSingle();
      if (existing != null) {
        throw AuthException("Email already registered.");
      } else {
        final response = await _supabase.auth.signUp(email: email, password: password);
        final user = response.user;
        log("Response of register ${response.user}");
        
        final hashedPassword = hashPassword(password); 
        await _supabase.from('users').insert({
          'id': user!.id,
          'name': name,
          'email': email,
          'password': hashedPassword, 
        });
      }

    } catch (e) {
      throw AuthException("Email already registered.");
    }
  }

  Future<void> signIn(String email, String password) async {
    final response = await _supabase.auth.signInWithPassword(email: email, password: password);
    print(response.user);
    if (response.user == null) {
      throw Exception('Invalid credentials');
    }
  }

  
  String hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }
}

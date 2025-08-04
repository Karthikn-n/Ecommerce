import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:e_commerce/data/model/cart_model.dart';
import 'package:e_commerce/data/model/category_model.dart';
import 'package:e_commerce/data/model/products_model.dart';
import 'package:e_commerce/data/model/profile_model.dart';
import 'package:e_commerce/helper/shared_preferences_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final _supabase = Supabase.instance.client;
  final prefs = SharedPreferencesHelper.instance;

  // Signup with email and password
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
        throw AuthException("User already exists. Kindly login");
      }
      final response = await _supabase.auth.signUp(email: email, password: password);
      final user = response.user;
      log("Response of register ${response.user}");
      await prefs.setString("userId", user!.id);
      final hashedPassword = hashPassword(password); 
      await _supabase.from('users').insert({
        'id': user.id,
        'name': name,
        'email': email,
        'password': hashedPassword, 
      }).select().single();

    } on AuthException catch(_) {
      throw AuthException("User already exists", statusCode: "422");
    } on Exception catch (e) {
      log("Something went wrong in signup", error: e.toString(), stackTrace: StackTrace.current);
      throw Exception(e.toString());
    }
  }

  // signin with email and password
  Future<void> signIn(String email, String password) async {
    final response = await _supabase.auth.signInWithPassword(email: email, password: password);
    if (response.user == null) {
      throw Exception('Invalid credentials');
    } else {
      log("User id",name: response.user!.id);
      await prefs.setString("userId", response.user!.id);
      print(prefs.getString("userId"));
    }
  }

  // Hash the password for security
  String hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  // Fetch all the products from the database
  Future<List<ProductsModel>> fetchProducts() async {
    try {
      final response = await _supabase.from("products").select();
      log("Products response: $response");
      if (response.isEmpty) {
        return [];
      } else {
        return response.map((product) => ProductsModel.fromJson(product),).toList();
      }
    } catch (e) {
      throw Exception("No data found");
    }
  }
  
  // List of categories fetch category names
  Future<List<CategoryModel>> fetchCategory() async {
    try {
      final response = await _supabase.from("categories").select();
      log("Category response: $response");
      if (response.isEmpty) {
        return [];
      } else {
        return response.map((product) => CategoryModel.fromJson(product),).toList();
      }
    } catch (e) {
      throw Exception("No data found");
    }
  }

  // Fetch user detail 
  Future<ProfileModel> fetchProfile() async {
    try {
      String? userId = prefs.getString("userId");
      final response = await _supabase
          .from("users")
          .select()
          .eq("id", userId!)
          .maybeSingle(); // returns Map<String, dynamic>? or null

      if (response == null) {
        throw Exception("No profile found");
      }

      return ProfileModel.fromJson(response);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // Fetch cart items from the table
  Future<List<CartModel>> fetchCartItems() async {
    String? userId = prefs.getString("userId");
    if(userId == null) throw Exception("User id not found");
    try {
    final response = await _supabase
      .from("cart")
      .select('id, userId, productCount, productId(*)')
      .eq("userId", userId);
      if (response.isNotEmpty) {
        return response.map((json) => CartModel.fromJson(json),).toList();
      } else{
        return [];
      }
    } catch (e) {
      log("Something went wrong in fetching cart item", error: e.toString(), stackTrace: StackTrace.current);
      throw Exception(e.toString());
    }
  }

  Future<bool> insertCartItem({
    required int productId,
    required int productCount,
  }) async {
    try {
      final userId = prefs.getString("userId");
      if(userId == null) throw Exception("User id not found");
      final response = await _supabase
          .from("cart")
          .insert({
            "userId": userId,
            "productId": productId,
            "productCount": productCount,
          })
          .select()
          .single(); // return inserted item if needed

      return response.isNotEmpty;
    } catch (e) {
      log("Something went wrong in inserting cart item", error: e.toString());
      throw Exception("Failed to insert item to cart");
    }
  }


  Future<bool> addProduct(int value, int id) async {
    try {

      String? userId = prefs.getString("userId");
      if(userId == null) throw Exception("User id not found");
      final response = await _supabase
        .from("cart")
        .update({
          "productCount": value
        })
        .eq("id", id)
        .eq("userId", userId)
        .select();
      if (response.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Something went wrong in adding cart item", error: e.toString(), stackTrace: StackTrace.current);
      throw Exception(e.toString());
    }
  }

  Future<bool> removeProduct(int value, int id) async {
    try {

      String? userId = prefs.getString("userId");
      if(userId == null) throw Exception("User id not found");
      final response = await _supabase
        .from("cart")
        .update({
          "productCount": value
        })
        .eq("id", id)
        .eq("userId", userId)
        .select();
      if (response.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Something went wrong in adding cart item", error: e.toString(), stackTrace: StackTrace.current);
      throw Exception(e.toString());
    }
  }

  Future<bool> deleteCartItem(int cartId) async {
    try {
      String? userId = prefs.getString("userId");
      if(userId == null) throw Exception("User id not found");
      final response = await _supabase
          .from("cart")
          .delete()
          .eq("id", cartId)
          .eq("userId", userId)
          .select();

      return response.isNotEmpty;
    } catch (e) {
      log("Something went wrong in deleting cart item", error: e.toString(), stackTrace: StackTrace.current);
      throw Exception(e.toString());
    }
  }

  Future<void> clearCartForUser(String userId) async {
    try {
      final response = await _supabase
          .from('cart')
          .delete()
          .eq('userId', userId)
          .select();
    
    } catch (e) {
      log("Error clearing cart for user", error: e.toString(), stackTrace: StackTrace.current);
      throw Exception("Failed to clear cart");
    }
  }


  Future<ProfileModel> getUserProfile() async {
    try {
      final userId = prefs.getString("userId");
      if(userId == null) throw Exception("User id not found");
      final response = await _supabase
          .from('users')
          .select()
          .eq('id', userId)
          .single();
      log("Profile response: $response");
      return ProfileModel.fromJson(response);
    } catch (e) {
      log("Something went wrong in profile", error: e.toString(), stackTrace: StackTrace.current);
      throw Exception("Failed to fetch profile");
    }
  }


  Future<void> signout() async {
    await prefs.clear();
  }
  


}

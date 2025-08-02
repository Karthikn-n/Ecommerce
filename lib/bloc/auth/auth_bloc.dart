import 'dart:developer';

import 'package:e_commerce/bloc/auth/auth_event.dart';
import 'package:e_commerce/bloc/auth/auth_state.dart';
import 'package:e_commerce/data/service/supabase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final _authService = SupabaseService();

  AuthBloc() : super(AuthState()) {
    // toggle the password visibility here
    on<TogglePasswordVisibility>((event, emit) {
      emit(state.singinCopyWith(isPasswordVisible: !state.isPasswordVisible));
    },);

    // Emit the signup password visibilyt
    on<SignupTogglePasswordVisibility>((event, emit) {
      emit(state.signupCopyWith(isSignupPasswordVisible: !state.isSignupPasswordVisible, singupError: null));
    },);

    // Emit the signup confirm password visibilyt
    on<SignupToggleConfirmPasswordVisibility>((event, emit) {
      emit(state.signupCopyWith(isSignupConfirmPasswordVisible: !state.isSignupConfirmPasswordVisible, singupError: null));
    },);
    
    on<ClearSignupError>((event, emit) => emit(state.signupCopyWith(singupError: null)),);

    on<ClearSigninError>((event, emit) => emit(state.singinCopyWith(errorMessage: null)),);

    on<SignUpRequested>(_handleSignUp);

    on<SignInRequested>(_handleSignin);
  }


  Future<void> _handleSignUp(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(state.signupCopyWith(isSignupLoading: true, singupError: null, isSingupSuccess: false));
    try {
      await _authService.signUpWithDetails(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      emit(state.signupCopyWith(isSignupLoading: false, isSingupSuccess: true, singupError: null));
    }  on AuthException catch (e) {
      log("signup error", error: e.message);
      emit(state.signupCopyWith(isSignupLoading: false, singupError: e.message));
    }  on Exception catch (e) { 
      log("Something went wrong in signup", error: e.toString(), stackTrace: StackTrace.current);
      emit(state.signupCopyWith(isSignupLoading: false, singupError: e.toString()));
    }
  }

  Future<void> _handleSignin(SignInRequested event, Emitter<AuthState> emit) async {
    emit(state.singinCopyWith(isLoading: true, errorMessage: null, isSuccess: false));
    try {
      await _authService.signIn(event.email, event.password);
      emit(state.singinCopyWith(isLoading: false, isSuccess: true));
    }  on AuthException catch (e) {
      log("Signin error", error: e.message);
      emit(state.singinCopyWith(isLoading: false, errorMessage: e.message));
    } catch (e) {
      log("Something went wrong in sigin", error: e.toString(), stackTrace: StackTrace.current);
      emit(state.singinCopyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

}


import 'package:e_commerce/bloc/profile/profile_state.dart';
import 'package:e_commerce/data/service/supabase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final _supabaseService = SupabaseService();

  ProfileCubit() : super(ProfileState());

  Future<void> fetchProfile() async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final user = await _supabaseService.getUserProfile();
      emit(state.copyWith(isLoading: false, user: user));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> signout() async {
    emit(state.copyWith(signout: true));
    await _supabaseService.signout();
  }
}

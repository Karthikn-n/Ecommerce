import 'package:e_commerce/data/model/profile_model.dart';

class ProfileState {
  final bool isLoading;
  final String? error;
  final ProfileModel? user;
  final bool signout;

  ProfileState({
    this.isLoading = false,
    this.error,
    this.user,
    this.signout = false,
  });

  ProfileState copyWith({
    bool? isLoading,
    String? error,
    ProfileModel? user,
    bool? signout,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      user: user ?? this.user,
      signout: signout ?? this.signout
    );
  }
}

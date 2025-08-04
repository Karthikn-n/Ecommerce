class AuthState {
  final bool isLoading;
  final bool isSignupLoading;
  final bool isSignupPasswordVisible;
  final bool isSignupConfirmPasswordVisible;
  final bool isPasswordVisible;
  final String? errorMessage;
  final bool isSuccess;
  final String? signupError;
  final bool isSignupSuccess;

  AuthState({
    this.isLoading = false,
    this.isPasswordVisible = false,
    this.errorMessage,
    this.isSignupLoading = false,
    this.isSignupConfirmPasswordVisible = false,
    this.isSignupPasswordVisible = false,
    this.isSuccess = false,
    this.signupError,
    this.isSignupSuccess = false,
  });

  AuthState singinCopyWith({
    bool? isLoading,
    bool? isPasswordVisible,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      errorMessage: errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  AuthState signupCopyWith({
    bool? isSignupLoading,
    bool? isSignupPasswordVisible,
    bool? isSignupConfirmPasswordVisible,
    bool? isSignupSuccess,
    String? signupError,
  }) {
    return AuthState(
      isSignupLoading: isSignupLoading ?? this.isSignupLoading,
      isSignupPasswordVisible: isSignupPasswordVisible ?? this.isSignupPasswordVisible,
      isSignupConfirmPasswordVisible: isSignupConfirmPasswordVisible ?? this.isSignupConfirmPasswordVisible,
      isSignupSuccess: isSignupSuccess ?? this.isSignupSuccess,
      signupError: signupError ?? this.signupError,
    );
  }
}


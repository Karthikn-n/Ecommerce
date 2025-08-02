class AuthState {
  final bool isLoading;
  final bool isSignupLoading;
  final bool isSignupPasswordVisible;
  final bool isSignupConfirmPasswordVisible;
  final bool isPasswordVisible;
  final String? errorMessage;
  final bool isSuccess;
  final String? singupError;
  final bool isSingupSuccess;

  AuthState({
    this.isLoading = false,
    this.isPasswordVisible = false,
    this.errorMessage,
    this.isSignupLoading = false,
    this.isSignupConfirmPasswordVisible = false,
    this.isSignupPasswordVisible = false,
    this.isSuccess = false,
    this.singupError,
    this.isSingupSuccess = false,
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
    bool? isSingupSuccess,
    String? singupError,
  }) {
    return AuthState(
      isSignupLoading: isSingupSuccess ?? this.isSingupSuccess,
      isSignupPasswordVisible: isSignupPasswordVisible ?? this.isSignupPasswordVisible,
      isSignupConfirmPasswordVisible: isSignupConfirmPasswordVisible ?? this.isSignupConfirmPasswordVisible,
      isSingupSuccess: isSingupSuccess ?? this.isSingupSuccess,
      singupError: singupError ?? this.singupError,
    );
  }
}


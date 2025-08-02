abstract class AuthEvent {}

class TogglePasswordVisibility extends AuthEvent {}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;
  
  SignInRequested(this.email, this.password);
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;
  final String name;

  SignUpRequested(this.email, this.password, this.confirmPassword, this.name);
}

class SignupTogglePasswordVisibility extends AuthEvent {}

class SignupToggleConfirmPasswordVisibility extends AuthEvent {}

class ClearSignupError extends AuthEvent{}
class ClearSigninError extends AuthEvent{}

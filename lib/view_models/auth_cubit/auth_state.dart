sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoadoing extends AuthState {}

final class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
}

final class AuthDone extends AuthState {}

final class AuthLogingOut extends AuthState {}

final class AuthLogedOut extends AuthState {}

final class AuthLogedOutError extends AuthState {
  final String error;

  AuthLogedOutError(this.error);
}

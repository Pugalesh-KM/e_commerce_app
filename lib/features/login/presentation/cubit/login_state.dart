part of 'login_cubit.dart';

abstract class LoginState {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final String usernameError;
  final String passwordError;
  final bool isLoading;
  final bool isError;
  final String errorMessage;
  final int userId;

  const LoginLoaded( {
    this.userId = 0,
    this.usernameError = '',
    this.passwordError = '',
    this.isLoading = false,
    this.isError = false,
    this.errorMessage = '',
  });

  LoginLoaded copyWith({
    String? usernameError,
    String? passwordError,
    bool? isLoading,
    bool? isError,
    String? errorMessage,
    int? userId,
  }) {
    return LoginLoaded(
      usernameError: usernameError ?? this.usernameError,
      passwordError: passwordError ?? this.passwordError,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      userId: userId ?? this.userId,
    );
  }

  @override
  List<Object> get props => [
    userId,
    usernameError,
    passwordError,
    isLoading,
    isError,
    errorMessage,
  ];
}

class LoginSuccess extends LoginState {
  final LoginResponse user;

  LoginSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);
}

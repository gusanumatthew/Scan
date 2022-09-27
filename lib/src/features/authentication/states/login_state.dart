class LoginState {
  final bool isLoading;
  final bool obscureText;
  LoginState({
    this.obscureText = true,
    this.isLoading = false,
  });

  LoginState copyWith({bool? isLoading, bool? obscureText}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      obscureText: obscureText ?? this.obscureText,
    );
  }
}

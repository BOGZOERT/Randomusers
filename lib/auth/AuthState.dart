class AuthState {

  final bool allowEditing;
  final bool isLoading;
  final AuthStateResult? result;
  final String? username;

  AuthState({
    required this.allowEditing,
    required this.isLoading,
    required this.result,
    required this.username,
  });

  AuthState copy({
    bool? allowEditing,
    bool? isLoading,
    AuthStateResult? result,
    String? username,
  }) {
    return AuthState(
      allowEditing: allowEditing ?? this.allowEditing,
      isLoading: isLoading ?? this.isLoading,
      result: result ?? this.result,
      username: username ?? this.username,
    );
  }
}

enum AuthStateResult {
  success,
  failure,
}
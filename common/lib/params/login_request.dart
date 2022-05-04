class LoginRequestParams {
  const LoginRequestParams({
    required this.password,
    required this.email,
  });

  final String email;
  final String password;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'email': email,
        'password': password,
      };
}

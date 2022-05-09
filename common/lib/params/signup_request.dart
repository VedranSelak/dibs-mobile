class SignUpRequestParams {
  const SignUpRequestParams({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.type,
    required this.status,
  });

  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String type;
  final String status;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'password': password,
        'type': type,
        'status': status,
      };
}

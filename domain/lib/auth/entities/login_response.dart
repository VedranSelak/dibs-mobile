import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  const LoginResponse({
    required this.accessToken,
  });

  final String accessToken;

  @override
  List<Object> get props => [accessToken];
}

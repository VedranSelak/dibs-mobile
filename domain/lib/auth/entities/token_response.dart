import 'package:equatable/equatable.dart';

class TokenResponse extends Equatable {
  const TokenResponse({
    required this.accessToken,
  });

  final String accessToken;

  @override
  List<Object> get props => [accessToken];
}

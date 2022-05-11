import 'package:app/res/account_type.dart';
import 'package:domain/auth/entities/user.dart';
import 'package:domain/auth/usecases/get_user_usecase.dart';
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:get_it/get_it.dart';
import "package:meta/meta.dart";

part "user_type_event.dart";
part "user_type_state.dart";

class UserTypeBloc extends Bloc<UserTypeEvent, UserTypeState> {
  UserTypeBloc() : super(GuestType()) {
    on<GetUserType>(_onGetUserType);
  }

  final GetUserUseCase _getUserUseCase = GetIt.I.get<GetUserUseCase>();

  void _onGetUserType(GetUserType event, Emitter<UserTypeState> emit) async {
    final user = await _getUserUseCase(params: null);
    print(user);
    if (user == null) {
      emit(GuestType());
    } else if (user.type == AccountType.user.rawValue) {
      emit(UserType(user: user));
    } else if (user.type == AccountType.owner.rawValue) {
      emit(OwnerType(user: user));
    }
  }
}

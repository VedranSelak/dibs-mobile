import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerModeCubit extends Cubit<bool> {
  OwnerModeCubit() : super(false);

  void toggleMode() {
    emit(!state);
  }
}

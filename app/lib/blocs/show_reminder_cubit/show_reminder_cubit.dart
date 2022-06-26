import 'package:flutter_bloc/flutter_bloc.dart';

class ShowReminderCubit extends Cubit<bool> {
  ShowReminderCubit() : super(true);

  void closeReminder() {
    emit(false);
  }
}

import 'package:app/blocs/test_bloc/test_bloc.dart';
import 'package:common/base_di_module.dart';
import 'package:get_it/get_it.dart';

class BlocModule extends BaseDiModule {
  @override
  void inject() {
    /// Blocs
    GetIt.I.registerFactory<TestBloc>(TestBloc.new);
  }
}

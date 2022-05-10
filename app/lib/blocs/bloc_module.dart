import 'package:app/blocs/listing_bloc/listing_bloc.dart';
import 'package:app/blocs/login_bloc/login_bloc.dart';
import 'package:app/blocs/signup_bloc/signup_bloc.dart';
import 'package:app/blocs/test_bloc/test_bloc.dart';
import 'package:common/base_di_module.dart';
import 'package:get_it/get_it.dart';

class BlocModule extends BaseDiModule {
  @override
  void inject() {
    /// Blocs
    GetIt.I.registerFactory<TestBloc>(TestBloc.new);
    GetIt.I.registerFactory<LoginBloc>(LoginBloc.new);
    GetIt.I.registerFactory<SignUpBloc>(SignUpBloc.new);
    GetIt.I.registerFactory<ListingBloc>(ListingBloc.new);
  }
}

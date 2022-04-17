import 'package:domain/placeholder_api/entities/post.dart';
import 'package:domain/placeholder_api/usecases/get_posts_usecase.dart';
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:get_it/get_it.dart';
import "package:meta/meta.dart";

part "test_event.dart";
part "test_state.dart";

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(TestInitial()) {
    on<TestGetData>(_getData);
  }

  final GetPostsUseCase _getPostsUseCase = GetIt.I.get<GetPostsUseCase>();

  void _getData(TestGetData event, Emitter<TestState> emit) async {
    emit(TestLoading());
    final posts = await _getPostsUseCase.call();
    for (final Post post in posts.data!) {
      print(post);
    }
    emit(TestLoaded());
  }
}

import 'package:app/ui/features/create_listing/enter_images_screen.dart';
import 'package:domain/public_listing/usecases/post_listing_images_usecase.dart';
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import "package:meta/meta.dart";

part "create_listing_event.dart";
part "create_listing_state.dart";

class CreateListingBloc extends Bloc<CreateListingEvent, CreateListingState> {
  CreateListingBloc() : super(CreateListingInitial()) {
    on<EnterListingData>(_onEnterListingData);
    on<AddListingImages>(_onAddListingImages);
    on<RemoveListingImage>(_onRemoveListingImage);
    on<SubmitListing>(_onSubmitListing);
  }

  final PostListingImagesUseCase _postListingImagesUseCase = GetIt.I.get<PostListingImagesUseCase>();

  void _onEnterListingData(EnterListingData event, Emitter<CreateListingState> emit) {
    Get.toNamed<dynamic>(EnterImagesScreen.routeName);
    if (event.images != null) {
      emit(ListingImagesEntered(
        name: event.name,
        shortDesc: event.shortDesc,
        detailedDesc: event.detailedDesc,
        type: event.type,
        images: event.images ?? [],
      ));
    } else {
      emit(ListingDataEntered(
        name: event.name,
        shortDesc: event.shortDesc,
        detailedDesc: event.detailedDesc,
        type: event.type,
      ));
    }
  }

  void _onAddListingImages(AddListingImages event, Emitter<CreateListingState> emit) async {
    if (state is ListingImagesEntered && (state as ListingImagesEntered).images.length >= 6) {
      return;
    }
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();
    final currentState = state;
    if (currentState is ListingDataEntered) {
      emit(ListingImagesEntered(
        name: currentState.name,
        shortDesc: currentState.shortDesc,
        detailedDesc: currentState.detailedDesc,
        type: currentState.type,
        images: images?.sublist(0, images.length < 6 ? images.length : 6) ?? [],
      ));
    } else if (currentState is ListingImagesEntered) {
      final List<XFile> allImages = [...currentState.images, ...images ?? []];
      emit(ListingImagesEntered(
        name: currentState.name,
        shortDesc: currentState.shortDesc,
        detailedDesc: currentState.detailedDesc,
        type: currentState.type,
        images: allImages.sublist(0, allImages.length < 6 ? allImages.length : 6),
      ));
    }
  }

  void _onRemoveListingImage(RemoveListingImage event, Emitter<CreateListingState> emit) {
    final currentState = state;
    if (currentState is ListingImagesEntered) {
      currentState.images.removeAt(event.index);
      final images = [...currentState.images];
      emit(CreateListingInitial());
      emit(ListingImagesEntered(
        name: currentState.name,
        shortDesc: currentState.shortDesc,
        detailedDesc: currentState.detailedDesc,
        type: currentState.type,
        images: images,
      ));
    }
  }

  void _onSubmitListing(SubmitListing event, Emitter<CreateListingState> emit) async {
    final currentState = state;
    if (currentState is ListingImagesEntered) {
      final name = currentState.name;
      final shortDesc = currentState.shortDesc;
      final detailedDesc = currentState.detailedDesc;
      final type = currentState.type;
      emit(CreateListingInProgress());
      final imagePaths = currentState.images.map((i) => i.path).toList();
      final response = await _postListingImagesUseCase(params: imagePaths);
      final savedUrls = response.data ?? [];
      if (savedUrls.isEmpty) {
        emit(CreateListingFailure());
        return;
      }

      print(savedUrls.data);
    }
  }
}

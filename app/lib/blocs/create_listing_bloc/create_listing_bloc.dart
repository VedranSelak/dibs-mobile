import 'package:app/res/listing_type.dart';
import 'package:app/ui/features/create_listing/enter_listing_spots_screen.dart';
import 'package:common/params/create_listing_request.dart';
import 'package:domain/public_listing/usecases/post_listing_images_usecase.dart';
import 'package:domain/public_listing/entities/spot.dart';
import 'package:domain/public_listing/usecases/post_listing_usecase.dart';
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import "package:meta/meta.dart";

part "create_listing_event.dart";
part "create_listing_state.dart";

// THE WORST CODE I EVER WROTE

class CreateListingBloc extends Bloc<CreateListingEvent, CreateListingState> {
  CreateListingBloc() : super(CreateListingInitial()) {
    on<EnterListingData>(_onEnterListingData);
    on<AddListingImages>(_onAddListingImages);
    on<RemoveListingImage>(_onRemoveListingImage);
    on<SelectListingType>(_onSelectListingType);
    on<AddListingSpot>(_onAddListingSpot);
    on<EditListingSpot>(_onEditListingSpot);
    on<RemoveListingSpot>(_onRemoveListingSpot);
    on<SubmitListing>(_onSubmitListing);
    on<ResetCreateListingBloc>(_onResetCreateListingBloc);
  }

  final PostListingImagesUseCase _postListingImagesUseCase = GetIt.I.get<PostListingImagesUseCase>();
  final PostListingUseCase _postListingUseCase = GetIt.I.get<PostListingUseCase>();

  void _onEnterListingData(EnterListingData event, Emitter<CreateListingState> emit) {
    Get.toNamed<dynamic>(EnterListingSpotsScreen.routeName);
    final currentState = state;
    if (currentState is ListingImagesEntered) {
      emit(ListingImagesEntered(
        name: event.name,
        shortDesc: event.shortDesc,
        detailedDesc: event.detailedDesc,
        type: currentState.type,
        spots: currentState.spots,
        images: currentState.images,
      ));
    } else if (currentState is ListingSpotsEntered) {
      emit(ListingSpotsEntered(
        name: event.name,
        shortDesc: event.shortDesc,
        detailedDesc: event.detailedDesc,
        type: currentState.type,
        spots: currentState.spots,
      ));
    } else {
      emit(ListingDataEntered(
        name: event.name,
        shortDesc: event.shortDesc,
        detailedDesc: event.detailedDesc,
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
    if (currentState is ListingSpotsEntered) {
      emit(ListingImagesEntered(
        name: currentState.name,
        shortDesc: currentState.shortDesc,
        detailedDesc: currentState.detailedDesc,
        type: currentState.type,
        spots: currentState.spots,
        images: images?.sublist(0, images.length < 6 ? images.length : 6) ?? [],
      ));
    } else if (currentState is ListingImagesEntered) {
      final List<XFile> allImages = [...currentState.images, ...images ?? []];
      emit(ListingImagesEntered(
        name: currentState.name,
        shortDesc: currentState.shortDesc,
        detailedDesc: currentState.detailedDesc,
        type: currentState.type,
        spots: currentState.spots,
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
        spots: currentState.spots,
        images: images,
      ));
    }
  }

  void _onRemoveListingSpot(RemoveListingSpot event, Emitter<CreateListingState> emit) {
    final currentState = state;
    if (currentState is ListingImagesEntered) {
      if (event.rowName != null) {
        final newSpots = currentState.spots.where((spot) => spot.rowName! != event.rowName).toList();
        emit(ListingImagesEntered(
          name: currentState.name,
          shortDesc: currentState.shortDesc,
          detailedDesc: currentState.detailedDesc,
          type: currentState.type,
          spots: newSpots,
          images: currentState.images,
        ));
      } else {
        currentState.spots.removeAt(event.index);
        final newSpots = [...currentState.spots];
        emit(CreateListingInitial());
        emit(ListingImagesEntered(
          name: currentState.name,
          shortDesc: currentState.shortDesc,
          detailedDesc: currentState.detailedDesc,
          type: currentState.type,
          spots: newSpots,
          images: currentState.images,
        ));
      }
    } else if (currentState is ListingSpotsEntered) {
      if (event.rowName != null) {
        final newSpots = currentState.spots.where((spot) => spot.rowName! != event.rowName).toList();
        emit(ListingSpotsEntered(
          name: currentState.name,
          shortDesc: currentState.shortDesc,
          detailedDesc: currentState.detailedDesc,
          type: currentState.type,
          spots: newSpots,
        ));
      } else {
        currentState.spots.removeAt(event.index);
        final newSpots = [...currentState.spots];
        emit(CreateListingInitial());
        emit(ListingSpotsEntered(
          name: currentState.name,
          shortDesc: currentState.shortDesc,
          detailedDesc: currentState.detailedDesc,
          type: currentState.type,
          spots: newSpots,
        ));
      }
    }
  }

  void _onSelectListingType(SelectListingType event, Emitter<CreateListingState> emit) async {
    final currentState = state;
    if (currentState is ListingSpotsEntered) {
      emit(ListingSpotsEntered(
        name: currentState.name,
        shortDesc: currentState.shortDesc,
        detailedDesc: currentState.detailedDesc,
        type: event.type,
        spots: const [],
      ));
    } else if (currentState is ListingImagesEntered) {
      emit(ListingImagesEntered(
        name: currentState.name,
        shortDesc: currentState.shortDesc,
        detailedDesc: currentState.detailedDesc,
        type: event.type,
        spots: const [],
        images: currentState.images,
      ));
    } else if (currentState is ListingDataEntered) {
      emit(ListingSpotsEntered(
        name: currentState.name,
        shortDesc: currentState.shortDesc,
        detailedDesc: currentState.detailedDesc,
        type: event.type,
        spots: const [],
      ));
    }
  }

  void _onAddListingSpot(AddListingSpot event, Emitter<CreateListingState> emit) async {
    final currentState = state;
    if (currentState is ListingSpotsEntered) {
      final spots = [...currentState.spots, event.spot];
      emit(ListingSpotsEntered(
        name: currentState.name,
        shortDesc: currentState.shortDesc,
        detailedDesc: currentState.detailedDesc,
        type: currentState.type,
        spots: spots,
      ));
    } else if (currentState is ListingImagesEntered) {
      final spots = [...currentState.spots, event.spot];
      emit(ListingImagesEntered(
        name: currentState.name,
        shortDesc: currentState.shortDesc,
        detailedDesc: currentState.detailedDesc,
        type: currentState.type,
        spots: spots,
        images: currentState.images,
      ));
    }
  }

  void _onEditListingSpot(EditListingSpot event, Emitter<CreateListingState> emit) async {
    final currentState = state;
    if (currentState is ListingSpotsEntered) {
      if (event.rowName != null && event.prevRowName != null) {
        if (event.rowName == event.prevRowName) {
          final currentSpots = currentState.spots.where((spot) => spot.rowName! == event.prevRowName).toList().length;
          if (event.availableSpots >= currentSpots) {
            for (int i = 0; i < event.availableSpots - currentSpots; i++) {
              currentState.spots.add(Spot(availableSpots: 1, rowName: event.rowName));
            }
          } else {
            int found = 0;
            for (int i = 0; i < currentState.spots.length; i++) {
              if (currentState.spots[i].rowName == event.rowName) {
                found++;
                if (found > event.availableSpots) {
                  currentState.spots.removeAt(i);
                  i--;
                }
              }
            }
          }
        } else {
          for (int i = 0; i < event.availableSpots; i++) {
            final index = currentState.spots.indexWhere((spot) => spot.rowName! == event.prevRowName);
            if (index < 0) {
              currentState.spots.add(Spot(availableSpots: 1, rowName: event.rowName));
            } else {
              currentState.spots[index].rowName = event.rowName;
            }
          }
        }
        List<Spot> spots = currentState.spots;
        if (event.rowName != event.prevRowName) {
          spots = currentState.spots.where((spot) => spot.rowName != event.prevRowName).toList();
        }
        emit(CreateListingInitial());
        emit(ListingSpotsEntered(
          name: currentState.name,
          shortDesc: currentState.shortDesc,
          detailedDesc: currentState.detailedDesc,
          type: currentState.type,
          spots: spots,
        ));
        return;
      }
      currentState.spots.elementAt(event.index).availableSpots = event.availableSpots;
      emit(CreateListingInitial());
      emit(ListingSpotsEntered(
        name: currentState.name,
        shortDesc: currentState.shortDesc,
        detailedDesc: currentState.detailedDesc,
        type: currentState.type,
        spots: currentState.spots,
      ));
    } else if (currentState is ListingImagesEntered) {
      if (event.rowName != null && event.prevRowName != null) {
        if (event.rowName == event.prevRowName) {
          final currentSpots = currentState.spots.where((spot) => spot.rowName! == event.prevRowName).toList().length;
          if (event.availableSpots >= currentSpots) {
            for (int i = 0; i < event.availableSpots - currentSpots; i++) {
              currentState.spots.add(Spot(availableSpots: 1, rowName: event.rowName));
            }
          } else {
            int found = 0;
            for (int i = 0; i < currentState.spots.length; i++) {
              if (currentState.spots[i].rowName == event.rowName) {
                found++;
                if (found > event.availableSpots) {
                  currentState.spots.removeAt(i);
                  i--;
                }
              }
            }
          }
        } else {
          for (int i = 0; i < event.availableSpots; i++) {
            final index = currentState.spots.indexWhere((spot) => spot.rowName! == event.prevRowName);
            if (index < 0) {
              currentState.spots.add(Spot(availableSpots: 1, rowName: event.rowName));
            } else {
              currentState.spots[index].rowName = event.rowName;
            }
          }
        }
        List<Spot> spots = currentState.spots;
        if (event.rowName != event.prevRowName) {
          spots = currentState.spots.where((spot) => spot.rowName != event.prevRowName).toList();
        }
        emit(CreateListingInitial());
        emit(ListingImagesEntered(
          name: currentState.name,
          shortDesc: currentState.shortDesc,
          detailedDesc: currentState.detailedDesc,
          type: currentState.type,
          spots: spots,
          images: currentState.images,
        ));
        return;
      }
      currentState.spots.elementAt(event.index).availableSpots = event.availableSpots;
      emit(CreateListingInitial());
      emit(ListingImagesEntered(
        name: currentState.name,
        shortDesc: currentState.shortDesc,
        detailedDesc: currentState.detailedDesc,
        type: currentState.type,
        spots: currentState.spots,
        images: currentState.images,
      ));
    }
  }

  void _onSubmitListing(SubmitListing event, Emitter<CreateListingState> emit) async {
    final currentState = state;
    if (currentState is ListingImagesEntered) {
      final name = currentState.name;
      final shortDesc = currentState.shortDesc;
      final detailedDesc = currentState.detailedDesc;
      final type = currentState.type.rawValue;
      emit(CreateListingInProgress(
        name: currentState.name,
        shortDesc: currentState.shortDesc,
        detailedDesc: currentState.detailedDesc,
        type: currentState.type,
        spots: currentState.spots,
        images: currentState.images,
      ));
      final imagePaths = currentState.images.map((i) => i.path).toList();
      final response = await _postListingImagesUseCase(params: imagePaths);
      final savedUrls = response.data ?? [];
      if (savedUrls.isEmpty) {
        emit(CreateListingFailure(
          name: currentState.name,
          shortDesc: currentState.shortDesc,
          detailedDesc: currentState.detailedDesc,
          type: currentState.type,
          spots: currentState.spots,
          images: currentState.images,
        ));
        return;
      }
      final List<SpotParams> spots = currentState.spots
          .map((spot) => SpotParams(availableSpots: spot.availableSpots, rowName: spot.rowName))
          .toList();
      final params = CreateListingRequestParams(
        name: name,
        shortDescription: shortDesc,
        detailedDescription: detailedDesc,
        type: type,
        spots: spots,
        images: savedUrls,
      );

      _postListingUseCase(params: params);
      print(savedUrls);
    }
  }

  void _onResetCreateListingBloc(ResetCreateListingBloc event, Emitter<CreateListingState> emit) async {
    emit(CreateListingInitial());
  }
}

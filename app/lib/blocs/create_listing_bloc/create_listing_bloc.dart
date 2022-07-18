import 'package:app/blocs/listing_created_cubit/listing_created_cubit.dart';
import 'package:app/res/listing_type.dart';
import 'package:app/ui/features/create_listing/enter_listing_spots_screen.dart';
import 'package:app/ui/features/home/home_screen.dart';
import 'package:app/ui/widgets/success_screen.dart';
import 'package:common/params/create_listing_request.dart';
import 'package:common/resources/data_state.dart';
import 'package:domain/public_listing/usecases/post_listing_images_usecase.dart';
import 'package:domain/public_listing/entities/spot.dart';
import 'package:domain/public_listing/usecases/post_listing_usecase.dart';
import "package:equatable/equatable.dart";
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

part "create_listing_event.dart";
part "create_listing_state.dart";

class CreateListingBloc extends Bloc<CreateListingEvent, CreateListingState> {
  CreateListingBloc(this.listingCreatedCubit) : super(CreateListingInitial()) {
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
  final ListingCreatedCubit listingCreatedCubit;

  void _onEnterListingData(EnterListingData event, Emitter<CreateListingState> emit) {
    Get.toNamed<dynamic>(EnterListingSpotsScreen.routeName);
    final currentState = state;
    if (currentState is ListingDataEntering) {
      emit(ListingDataEntering(
        name: event.name,
        shortDesc: event.shortDesc,
        detailedDesc: event.detailedDesc,
        type: currentState.type,
        spots: currentState.spots,
        images: currentState.images,
      ));
    } else {
      emit(ListingDataEntering(
        name: event.name,
        shortDesc: event.shortDesc,
        detailedDesc: event.detailedDesc,
        type: null,
        spots: null,
        images: null,
      ));
    }
  }

  void _onAddListingImages(AddListingImages event, Emitter<CreateListingState> emit) async {
    final currentState = state;
    if (currentState is ListingDataEntering && currentState.images != null && currentState.images!.length >= 6) {
      return;
    }
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();
    if (currentState is ListingDataEntering && currentState.images == null) {
      emit(ListingDataEntering(
        name: currentState.name,
        shortDesc: currentState.shortDesc,
        detailedDesc: currentState.detailedDesc,
        type: currentState.type,
        spots: currentState.spots,
        images: images?.sublist(0, images.length < 6 ? images.length : 6),
      ));
    } else if (currentState is ListingDataEntering) {
      final List<XFile> allImages = [...currentState.images!, ...images ?? []];
      emit(ListingDataEntering(
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
    if (currentState is ListingDataEntering && currentState.images != null) {
      final images = [...currentState.images!]..removeAt(event.index);
      emit(CreateListingInitial());
      emit(ListingDataEntering(
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
    if (currentState is ListingDataEntering && currentState.spots != null) {
      if (event.rowName != null) {
        final newSpots = currentState.spots!.where((spot) => spot.rowName! != event.rowName).toList();
        emit(ListingDataEntering(
          name: currentState.name,
          shortDesc: currentState.shortDesc,
          detailedDesc: currentState.detailedDesc,
          type: currentState.type,
          spots: newSpots,
          images: currentState.images,
        ));
      } else {
        currentState.spots!.removeAt(event.index);
        final newSpots = [...currentState.spots!];
        emit(CreateListingInitial());
        emit(ListingDataEntering(
          name: currentState.name,
          shortDesc: currentState.shortDesc,
          detailedDesc: currentState.detailedDesc,
          type: currentState.type,
          spots: newSpots,
          images: currentState.images,
        ));
      }
    }
  }

  void _onSelectListingType(SelectListingType event, Emitter<CreateListingState> emit) async {
    final currentState = state;
    if (currentState is ListingDataEntering) {
      emit(ListingDataEntering(
        name: currentState.name,
        shortDesc: currentState.shortDesc,
        detailedDesc: currentState.detailedDesc,
        type: event.type,
        spots: const [],
        images: currentState.images,
      ));
    }
  }

  void _onAddListingSpot(AddListingSpot event, Emitter<CreateListingState> emit) async {
    final currentState = state;
    if (currentState is ListingDataEntering && currentState.spots != null) {
      final spots = [...currentState.spots!, event.spot];
      emit(ListingDataEntering(
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
    if (currentState is ListingDataEntering && currentState.spots != null) {
      if (event.rowName != null && event.prevRowName != null) {
        if (event.rowName == event.prevRowName) {
          final currentSpots = currentState.spots!.where((spot) => spot.rowName! == event.prevRowName).toList().length;
          if (event.availableSpots >= currentSpots) {
            for (int i = 0; i < event.availableSpots - currentSpots; i++) {
              currentState.spots!.add(Spot(availableSpots: 1, rowName: event.rowName));
            }
          } else {
            int found = 0;
            for (int i = 0; i < currentState.spots!.length; i++) {
              if (currentState.spots![i].rowName == event.rowName) {
                found++;
                if (found > event.availableSpots) {
                  currentState.spots!.removeAt(i);
                  i--;
                }
              }
            }
          }
        } else {
          for (int i = 0; i < event.availableSpots; i++) {
            final index = currentState.spots!.indexWhere((spot) => spot.rowName! == event.prevRowName);
            if (index < 0) {
              currentState.spots!.add(Spot(availableSpots: 1, rowName: event.rowName));
            } else {
              currentState.spots![index].rowName = event.rowName;
            }
          }
        }
        List<Spot> spots = currentState.spots!;
        if (event.rowName != event.prevRowName) {
          spots = currentState.spots!.where((spot) => spot.rowName != event.prevRowName).toList();
        }
        emit(CreateListingInitial());
        emit(ListingDataEntering(
          name: currentState.name,
          shortDesc: currentState.shortDesc,
          detailedDesc: currentState.detailedDesc,
          type: currentState.type,
          spots: spots,
          images: currentState.images,
        ));
        return;
      }
      currentState.spots!.elementAt(event.index).availableSpots = event.availableSpots;
      emit(CreateListingInitial());
      emit(ListingDataEntering(
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
    if (currentState is ListingDataEntering && currentState.images != null && currentState.images!.length > 2) {
      final name = currentState.name;
      final shortDesc = currentState.shortDesc;
      final detailedDesc = currentState.detailedDesc;
      final type = currentState.type!.rawValue;
      emit(CreateListingInProgress(
        name: currentState.name,
        shortDesc: currentState.shortDesc,
        detailedDesc: currentState.detailedDesc,
        type: currentState.type!,
        spots: currentState.spots!,
        images: currentState.images!,
      ));
      final imagePaths = currentState.images!.map((i) => i.path).toList();
      final cloudinaryResponse = await _postListingImagesUseCase(params: imagePaths);
      final savedUrls = cloudinaryResponse.data ?? [];
      if (savedUrls.isEmpty) {
        emit(ListingDataEntering(
          name: currentState.name,
          shortDesc: currentState.shortDesc,
          detailedDesc: currentState.detailedDesc,
          type: currentState.type!,
          spots: currentState.spots!,
          images: currentState.images!,
          errorMessage: "Unable to upload images. Try again later.",
        ));
        return;
      }
      final List<SpotParams> spots = currentState.spots!
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

      final response = await _postListingUseCase(params: params);
      if (response is DataFailed) {
        if (response.error?.response?.statusCode != null && response.error?.response?.statusCode == 401) {
          emit(ListingDataEntering(
            name: currentState.name,
            shortDesc: currentState.shortDesc,
            detailedDesc: currentState.detailedDesc,
            type: currentState.type!,
            spots: currentState.spots!,
            images: currentState.images!,
            errorMessage: "Your session has expired. Please log in again.",
          ));
        } else {
          emit(ListingDataEntering(
            name: currentState.name,
            shortDesc: currentState.shortDesc,
            detailedDesc: currentState.detailedDesc,
            type: currentState.type!,
            spots: currentState.spots!,
            images: currentState.images!,
            errorMessage: "Something went wrong. Try again later.",
          ));
        }
      } else {
        Get.offAll<dynamic>(
            SuccessScreen(
              isListing: true,
              beforeClose: (BuildContext context) {
                context.read<ListingCreatedCubit>().checkHasListing();
              },
            ),
            predicate: ModalRoute.withName(HomeScreen.routeName));
        listingCreatedCubit.checkHasListing();
        emit(CreateListingInitial());
      }
    } else if (currentState is ListingDataEntering) {
      emit(ListingDataEntering(
        name: currentState.name,
        shortDesc: currentState.shortDesc,
        detailedDesc: currentState.detailedDesc,
        type: currentState.type,
        spots: currentState.spots,
        images: currentState.images,
        errorMessage: "Please enter at lease 3 images.",
      ));
    }
  }

  void _onResetCreateListingBloc(ResetCreateListingBloc event, Emitter<CreateListingState> emit) async {
    emit(CreateListingInitial());
  }
}

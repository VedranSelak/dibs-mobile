class CreateListingRequestParams {
  const CreateListingRequestParams({
    required this.name,
    required this.shortDescription,
    required this.detailedDescription,
    required this.type,
    required this.spots,
    required this.images,
  });

  final String name;
  final String shortDescription;
  final String detailedDescription;
  final String type;
  final List<SpotParams> spots;
  final List<String> images;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'shortDescription': shortDescription,
        'detailedDescription': detailedDescription,
        'type': type,
        'spots': spots,
        'images': images,
      };
}

class SpotParams {
  const SpotParams({
    required this.availableSpots,
    this.rowName,
  });

  final int availableSpots;
  final String? rowName;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'availableSpots': availableSpots,
        'rowName': rowName,
      };
}

class CreateListingRequestParams {
  const CreateListingRequestParams({
    required this.name,
    required this.shortDescription,
    required this.detailedDescription,
    required this.type,
    required this.images,
  });

  final String name;
  final String shortDescription;
  final String detailedDescription;
  final String type;
  final List<String> images;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'shortDescription': shortDescription,
        'detailedDescription': detailedDescription,
        'type': type,
        'images': images,
      };
}

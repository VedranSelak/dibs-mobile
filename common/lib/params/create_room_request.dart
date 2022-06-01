class CreateRoomRequestParams {
  const CreateRoomRequestParams({
    required this.name,
    required this.description,
    required this.capacity,
    required this.imageUrl,
    required this.invites,
  });

  final String name;
  final String description;
  final int capacity;
  final String imageUrl;
  final List<int> invites;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'description': description,
        'capacity': capacity,
        'imageUrl': imageUrl,
        'invites': invites
      };
}

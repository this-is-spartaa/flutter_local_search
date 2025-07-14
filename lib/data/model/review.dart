class Review {
  final String id;
  final String content;
  final double mapX;
  final double mapY;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.content,
    required this.mapX,
    required this.mapY,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> map) => Review(
        id: map["id"],
        content: map["content"],
        mapX: map["mapX"],
        mapY: map["mapY"],
        createdAt: DateTime.parse(map["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "mapX": mapX,
        "mapY": mapY,
        "createdAt": createdAt.toIso8601String(),
      };
}

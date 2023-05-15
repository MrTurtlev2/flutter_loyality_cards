class LoyalityCard {
  final String id;
  final String name;
  final String code;
  final String image;

  const LoyalityCard({
    required this.id,
    required this.name,
    required this.code,
    required this.image,
  });

  factory LoyalityCard.fromJson(Map<String, dynamic> json) {
    return LoyalityCard(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      image: json['image'],
    );
  }
}
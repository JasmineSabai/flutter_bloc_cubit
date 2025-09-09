class AdsItem {
  final int id;
  final String image;
  final String label;
  final String description;

  AdsItem({
    required this.id,
    required this.image,
    required this.label,
    required this.description,
  });

  factory AdsItem.fromMap(Map<String, dynamic> map) {
    return AdsItem(
      id: map['id'] ?? '',
      image: map['image'] ?? '',
      label: map['label'] ?? '',
      description: map['description'] ?? '',
    );
  }
}

class Gym {
  final String name;
  final String location;
  final double distance;
  final double rating;
  final int reviewsCount;
  final String imageUrl;
  final double pricePerSession;
  final List<String> tags;
  final String? badgeText;
  final bool isBookmarked;

  const Gym({
    required this.name,
    required this.location,
    required this.distance,
    required this.rating,
    required this.reviewsCount,
    required this.imageUrl,
    required this.pricePerSession,
    required this.tags,
    this.badgeText,
    this.isBookmarked = false,
  });
}

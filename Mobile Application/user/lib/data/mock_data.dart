import '../models/gym.dart';

class MockData {
  static const List<Gym> gyms = [
    Gym(
      name: "FitZone Gym",
      location: "Anna Nagar, Chennai",
      distance: 2.3,
      rating: 4.7,
      reviewsCount: 512,
      imageUrl: "https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=600&auto=format&fit=crop",
      pricePerSession: 75.0,
      tags: ["Strength", "Cardio", "CrossFit", "Zumba"],
      badgeText: "Popular",
      isBookmarked: true,
    ),
    Gym(
      name: "PowerHouse Gym",
      location: "T. Nagar, Chennai",
      distance: 3.1,
      rating: 4.6,
      reviewsCount: 398,
      imageUrl: "https://images.unsplash.com/photo-1540575467063-178a50c2df87?q=80&w=600&auto=format&fit=crop",
      pricePerSession: 69.0,
      tags: ["Bodybuilding", "Strength", "HIIT", "Cardio"],
      badgeText: "Best Equipment",
    ),
    Gym(
      name: "Core Fit Studio",
      location: "Adyar, Chennai",
      distance: 4.2,
      rating: 4.8,
      reviewsCount: 267,
      imageUrl: "https://images.unsplash.com/photo-1517838277536-f5f99be501cd?q=80&w=600&auto=format&fit=crop",
      pricePerSession: 85.0,
      tags: ["Functional", "CrossFit", "Yoga", "HIIT"],
      badgeText: "Premium",
      isBookmarked: true,
    ),
    Gym(
      name: "Active Life Fitness",
      location: "Besant Nagar, Chennai",
      distance: 5.0,
      rating: 4.5,
      reviewsCount: 184,
      imageUrl: "https://images.unsplash.com/photo-1518611012118-696072aa579a?q=80&w=600&auto=format&fit=crop",
      pricePerSession: 70.0,
      tags: ["Yoga", "Cardio", "Strength", "Pilates"],
      badgeText: "Yoga Friendly",
    ),
  ];
}

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/gym.dart';
import '../data/mock_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Selected filters
  String? _selectedType;
  String? _selectedFacility;
  String? _selectedWorkout;
  bool _isAllSelected = true;

  final List<Gym> _allGyms = MockData.gyms;
  List<Gym> _filteredGyms = MockData.gyms;

  void _filterGyms() {
    setState(() {
      _filteredGyms = _allGyms.where((gym) {
        // Simple type filter simulation
        if (_selectedType != null) {
          if (_selectedType == "Women Only" && !gym.name.contains("Zone")) return false;
          if (_selectedType == "Men Only" && gym.name.contains("Studio")) return false;
        }
        // Simple facility filter simulation
        if (_selectedFacility != null) {
          if (_selectedFacility == "AC" && gym.rating < 4.6) return false;
        }
        // Simple workout filter simulation
        if (_selectedWorkout != null) {
          if (!gym.tags.contains(_selectedWorkout)) return false;
        }
        return true;
      }).toList();
    });
  }

  void _clearFilters() {
    setState(() {
      _selectedType = null;
      _selectedFacility = null;
      _selectedWorkout = null;
      _isAllSelected = true;
      _filteredGyms = _allGyms;
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = AppTheme.getBackgroundColor(context);

    final List<Widget> tabs = [
      _buildExploreTab(context),
      const Center(child: Text("My Bookings Screen")),
      const Center(child: Text("Memberships Screen")),
      const Center(child: Text("Messages Screen")),
      const Center(child: Text("Profile Screen")),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: tabs[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.accentColor,
        unselectedItemColor: AppTheme.getSubtitleColor(context),
        backgroundColor: AppTheme.getCardColor(context),
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "My Bookings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_membership),
            label: "Memberships",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: "Messages",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _buildExploreTab(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Header Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.menu, color: AppTheme.getTextColor(context)),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Hi, Arjun! ",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.getTextColor(context),
                              ),
                            ),
                            const Text(
                              "👋",
                              style: TextStyle(fontSize: 22),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Find your perfect gym. Book it. Go!",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.getSubtitleColor(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.notifications_none,
                          color: AppTheme.getTextColor(context), size: 28),
                      onPressed: () {},
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          "3",
                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),

          // 2. Search & Filter Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.getCardColor(context),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: TextField(
                      style: TextStyle(color: AppTheme.getTextColor(context)),
                      decoration: InputDecoration(
                        hintText: "Search gyms, locations, or areas...",
                        hintStyle: TextStyle(color: AppTheme.getSubtitleColor(context).withOpacity(0.7)),
                        prefixIcon: Icon(Icons.search, color: AppTheme.getSubtitleColor(context)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.getCardColor(context),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.tune, color: AppTheme.accentColor),
                    label: const Text(
                      "Filter",
                      style: TextStyle(color: AppTheme.accentColor, fontWeight: FontWeight.bold),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 3. Promo Banner Carousel (Fitzone Gym 30% OFF)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    // Gym Banner background image
                    Positioned.fill(
                      child: Image.network(
                        "https://images.unsplash.com/photo-1540575467063-178a50c2df87?q=80&w=600&auto=format&fit=crop",
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Dark shade overlay
                    Positioned.fill(
                      child: Container(color: Colors.black.withOpacity(0.5)),
                    ),
                    // Banner content text
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppTheme.accentColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  "LIMITED TIME OFFER",
                                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                "FitZone Gym\n30% OFF",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  height: 1.2,
                                ),
                              ),
                              const Text(
                                "on Quarterly Membership",
                                style: TextStyle(color: Colors.white70, fontSize: 12),
                              ),
                            ],
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_forward, size: 16),
                            label: const Text("Book Now"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppTheme.primaryColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                          )
                        ],
                      ),
                    ),
                    // Countdown clock widget overlay at the top-right
                    Positioned(
                      top: 15,
                      right: 15,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF312E81).withOpacity(0.85), // Indigo dark
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Column(
                          children: [
                            Text(
                              "OFFER ENDS IN",
                              style: TextStyle(color: Colors.white70, fontSize: 8, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "05d : 12h\n: 30m",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // 4. Horizontal Dropdown Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                // "All" filter chip
                Material(
                  color: _isAllSelected
                      ? AppTheme.getActiveChipBg(context)
                      : AppTheme.getInactiveChipBg(context),
                  borderRadius: BorderRadius.circular(20),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: _clearFilters,
                    child: Ink(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _isAllSelected
                              ? Colors.transparent
                              : AppTheme.getInactiveChipBorder(context),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.grid_view_rounded,
                            size: 18,
                            color: _isAllSelected
                                ? AppTheme.getActiveChipText(context)
                                : AppTheme.getSubtitleColor(context),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "All",
                            style: TextStyle(
                              color: _isAllSelected
                                  ? AppTheme.getActiveChipText(context)
                                  : AppTheme.getTextColor(context),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // "Type" dropdown filter chip
                _buildFilterDropdown(
                  title: _selectedType ?? "Type",
                  isSelected: _selectedType != null,
                  options: ["Women Only", "Unisex", "Men Only"],
                  onSelected: (val) {
                    setState(() {
                      _selectedType = val;
                      _isAllSelected = false;
                      _filterGyms();
                    });
                  },
                  icon: Icons.person_outline,
                ),
                const SizedBox(width: 8),

                // "Facility" dropdown filter chip
                _buildFilterDropdown(
                  title: _selectedFacility ?? "Facility",
                  isSelected: _selectedFacility != null,
                  options: ["Parking", "Shower", "Locker Room", "Changing Room", "AC"],
                  onSelected: (val) {
                    setState(() {
                      _selectedFacility = val;
                      _isAllSelected = false;
                      _filterGyms();
                    });
                  },
                  icon: Icons.assignment_outlined,
                ),
                const SizedBox(width: 8),

                // "Workout" dropdown filter chip
                _buildFilterDropdown(
                  title: _selectedWorkout ?? "Workout",
                  isSelected: _selectedWorkout != null,
                  options: ["HIIT", "Yoga", "Dance", "Zumba", "CrossFit", "MMA", "Boxing"],
                  onSelected: (val) {
                    setState(() {
                      _selectedWorkout = val;
                      _isAllSelected = false;
                      _filterGyms();
                    });
                  },
                  icon: Icons.fitness_center,
                ),
                if (!_isAllSelected) ...[
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: _clearFilters,
                    child: const Text(
                      "Clear All",
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  )
                ]
              ],
            ),
          ),
          const SizedBox(height: 25),

          // 5. Gyms Header (All Gyms / counts)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Gyms",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.getTextColor(context),
                  ),
                ),
                Text(
                  "${_filteredGyms.length}+ gyms found",
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),

          // 6. Gym Cards List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredGyms.length,
              itemBuilder: (context, index) {
                final gym = _filteredGyms[index];
                return _buildGymCard(context, gym);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown({
    required String title,
    required bool isSelected,
    required List<String> options,
    required Function(String) onSelected,
    required IconData icon,
  }) {
    return Material(
      color: isSelected ? AppTheme.getActiveChipBg(context) : AppTheme.getInactiveChipBg(context),
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: PopupMenuButton<String>(
        onSelected: onSelected,
        color: AppTheme.getCardColor(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        itemBuilder: (context) => options
            .map(
              (opt) => PopupMenuItem<String>(
                value: opt,
                child: Text(
                  opt,
                  style: TextStyle(color: AppTheme.getTextColor(context)),
                ),
              ),
            )
            .toList(),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? Colors.transparent : AppTheme.getInactiveChipBorder(context),
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? AppTheme.getActiveChipText(context) : AppTheme.getSubtitleColor(context),
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? AppTheme.getActiveChipText(context) : AppTheme.getTextColor(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down,
                size: 18,
                color: isSelected ? AppTheme.getActiveChipText(context) : AppTheme.getSubtitleColor(context),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGymCard(BuildContext context, Gym gym) {
    final cardColor = AppTheme.getCardColor(context);
    final titleStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppTheme.getTextColor(context),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gym Preview image on the left
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: Image.network(
                  gym.imageUrl,
                  width: 130,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
              if (gym.badgeText != null)
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.accentColor.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.local_fire_department, color: Colors.white, size: 12),
                        const SizedBox(width: 2),
                        Text(
                          gym.badgeText!,
                          style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),

          // Gym Metadata on the right
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          gym.name,
                          style: titleStyle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        gym.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        color: gym.isBookmarked ? AppTheme.accentColor : AppTheme.getSubtitleColor(context),
                        size: 20,
                      )
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: AppTheme.getSubtitleColor(context), size: 14),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          "${gym.location} • ${gym.distance} km",
                          style: TextStyle(color: AppTheme.getSubtitleColor(context), fontSize: 11),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.getRatingBg(context),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.star, color: AppTheme.getRatingText(context), size: 12),
                            const SizedBox(width: 2),
                            Text(
                              gym.rating.toString(),
                              style: TextStyle(
                                color: AppTheme.getRatingText(context),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "(${gym.reviewsCount} reviews)",
                        style: TextStyle(color: AppTheme.getSubtitleColor(context), fontSize: 11),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // List of tag chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: gym.tags
                          .map(
                            (tag) => Container(
                              margin: const EdgeInsets.only(right: 6),
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppTheme.getBackgroundColor(context),
                                border: Border.all(color: AppTheme.getInactiveChipBorder(context)),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                tag,
                                style: const TextStyle(color: AppTheme.accentColor, fontSize: 9, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "₹${gym.pricePerSession.toInt()} ",
                              style: TextStyle(
                                color: AppTheme.getTextColor(context),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            TextSpan(
                              text: "/ session",
                              style: TextStyle(
                                color: AppTheme.getSubtitleColor(context),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: AppTheme.accentColor, size: 20),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';

class OffersView extends StatelessWidget {
  const OffersView({super.key});

  static const Color navy = Color(0xFF223263);
  static const Color blue = Color(0xFF40BFFF);
  static const Color grey = Color(0xFF9098B1);
  static const Color lightBlue = Color(0xFFEAF8FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Offers',
          style: TextStyle(
            color: navy,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Special Offers',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Discover great deals on your favorite products.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Icon(
                  Icons.local_offer_outlined,
                  size: 55,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            'Today\'s Deals',
            style: TextStyle(
              color: navy,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          _OfferCard(
            title: 'Special Discount',
            description: 'Save more on selected products.',
            discount: '30% OFF',
            icon: Icons.discount_outlined,
            color: const Color(0xFFFFEEF0),
            iconColor: const Color(0xFFFB7181),
          ),
          const SizedBox(height: 12),

          _OfferCard(
            title: 'Best Deals',
            description: 'Find great prices for your next purchase.',
            discount: 'HOT DEAL',
            icon: Icons.local_fire_department_outlined,
            color: lightBlue,
            iconColor: blue,
          ),
          const SizedBox(height: 12),

          _OfferCard(
            title: 'Limited Offers',
            description: 'Explore special offers while available.',
            discount: 'SPECIAL',
            icon: Icons.access_time,
            color: const Color(0xFFFFF5E5),
            iconColor: const Color(0xFFF5A623),
          ),
          const SizedBox(height: 20),

          
        ],
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  final String title;
  final String description;
  final String discount;
  final IconData icon;
  final Color color;
  final Color iconColor;

  const _OfferCard({
    required this.title,
    required this.description,
    required this.discount,
    required this.icon,
    required this.color,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF223263),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF9098B1),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              discount,
              style: TextStyle(
                color: iconColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MostOrderFoodWidget extends StatelessWidget {
  const MostOrderFoodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Most Ordered Food',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Adipiscing elit, sed do eiusmod tempor',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          _buildFoodItem(
            'Fresh Salad Bowl',
            'IDR 45.000',
            'assets/images/turkey-burger-index-64873e8770b34.jpg',
          ),
          const Divider(height: 24, color: Colors.grey),
          _buildFoodItem(
            'Chicken Noodles',
            'IDR 75.000',
            'assets/images/turkey-burger-index-64873e8770b34.jpg',
          ),
          const Divider(height: 24, color: Colors.grey),
          _buildFoodItem(
            'Smoothie Fruits',
            'IDR 45.000',
            'assets/images/turkey-burger-index-64873e8770b34.jpg',
          ),
          const Divider(height: 24, color: Colors.grey),
          _buildFoodItem(
            'Hot Chicken Wings',
            'IDR 45.000',
            'assets/images/turkey-burger-index-64873e8770b34.jpg',
          ),
        ],
      ),
    );
  }

  Widget _buildFoodItem(String name, String price, String imagePath) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          price,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

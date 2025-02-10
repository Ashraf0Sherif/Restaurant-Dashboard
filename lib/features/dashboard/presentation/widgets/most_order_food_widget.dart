import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/font_styles.dart';
import 'package:restaurant_admin_panel/features/dashboard/data/models/most_ordered_food_model.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/back_ground_container.dart';

class MostOrderFoodWidget extends StatelessWidget {
  final List<FoodItem> foodData;

  const MostOrderFoodWidget({
    super.key,
    this.foodData = const [
      FoodItem(
        name: 'Fresh Salad Bowl',
        price: 'IDR 45.000',
        imageUrl: 'assets/images/turkey-burger-index-64873e8770b34.jpg',
        orderCount: 120,
      ),
      FoodItem(
        name: 'Fresh Salad Bowl',
        price: 'IDR 45.000',
        imageUrl: 'assets/images/turkey-burger-index-64873e8770b34.jpg',
        orderCount: 120,
      ),
      FoodItem(
        name: 'Fresh Salad Bowl',
        price: 'IDR 45.000',
        imageUrl: 'assets/images/turkey-burger-index-64873e8770b34.jpg',
        orderCount: 120,
      ),
      FoodItem(
        name: 'Fresh Salad Bowl',
        price: 'IDR 45.000',
        imageUrl: 'assets/images/turkey-burger-index-64873e8770b34.jpg',
        orderCount: 120,
      ),
      FoodItem(
        name: 'Fresh Sa2xlad Bowl',
        price: 'IDR 45.000',
        imageUrl: 'assets/images/turkey-burger-index-64873e8770b34.jpg',
        orderCount: 120,
      ),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Most Ordered Food',
            style: TextStyle(
              fontSize: FontStyles.getResponsiveFontSize(context, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Adipiscing elit, sed do eiusmod tempor',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: FontStyles.getResponsiveFontSize(context, 14),
            ),
          ),
          const SizedBox(height: 20),
          for (var item in foodData)
            Column(
              children: [
                _buildFoodItem(
                  context,
                  item.name,
                  item.price,
                  item.imageUrl,
                ),
                //is item is the last
                if (foodData.indexOf(item) != foodData.length - 1)
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildFoodItem(
      BuildContext context, String name, String price, String imageUrl) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: FontStyles.getResponsiveFontSize(context, 16),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: FontStyles.getResponsiveFontSize(context, 14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_admin_panel/core/theming/font_styles.dart';
import 'package:restaurant_admin_panel/features/dashboard/data/models/most_ordered_food_model.dart';
import 'package:restaurant_admin_panel/features/dashboard/logic/most_ordered_food_cubit/most_ordered_food_cubit.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/back_ground_container.dart';

class MostOrderFoodWidget extends StatelessWidget {
  const MostOrderFoodWidget({
    super.key,
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
            'These are the most ordered foods in the restaurant.',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: FontStyles.getResponsiveFontSize(context, 14),
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<MostOrderedFoodCubit, MostOrderedFoodState>(
              builder: (context, state) {
            return state.maybeWhen(orElse: () {
              return const SizedBox();
            }, loading: () {
              return const SizedBox(
                height: 250,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }, loaded: (data) {
              return Column(
                children: [
                  for (var item in data)
                    Column(
                      children: [
                        _buildFoodItem(
                          context,
                          item
                        ),
                        if (data.indexOf(item) != data.length - 1)
                          const Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                      ],
                    ),
                ],
              );
            });
          }),
        ],
      ),
    );
  }

  Widget _buildFoodItem(
      BuildContext context, MostOrderedFoodModel item) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            item.imageUrl,
            fit: BoxFit.cover,
            height: 60,
            width: 60,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: TextStyle(
                fontSize: FontStyles.getResponsiveFontSize(context, 16),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item.orderCount.toString(),
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: FontStyles.getResponsiveFontSize(context, 14),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

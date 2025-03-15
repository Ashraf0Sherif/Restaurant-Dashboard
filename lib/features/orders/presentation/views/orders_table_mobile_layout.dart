import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/core/theming/font_styles.dart';
import '../../data/models/order_model.dart';

class OrdersTableMobileLayout extends StatelessWidget {
  final List<OrderModel> orders;

  const OrdersTableMobileLayout({
    super.key,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orders.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final order = orders[index];
        return buildOrderCard(context, order);
      },
    );
  }

  Widget buildOrderCard(BuildContext context, OrderModel order) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: _getStatusColor(order.status).withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.receipt_long, color: Colors.blueGrey),
                    const SizedBox(width: 8),
                    Text(
                      order.id,
                      style: TextStyle(
                        fontSize: FontStyles.getResponsiveFontSize(context, 16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Chip(
                  label: Text(
                    order.status,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: FontStyles.getResponsiveFontSize(context, 14),
                    ),
                  ),
                  backgroundColor: _getStatusColor(order.status),
                  avatar: _getStatusIcon(order.status),
                ),
              ],
            ),
          ),

          // Order details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                buildOrderDetailRow(
                  context,
                  'Order Name',
                  order.name,
                  Icons.inventory,
                  Colors.green,
                ),
                const SizedBox(height: 12),
                buildOrderDetailRow(
                  context,
                  'Order Price',
                  order.price,
                  Icons.attach_money_outlined,
                  Colors.blue,
                ),
                const SizedBox(height: 12),
                buildOrderDetailRow(
                  context,
                  'Ordered Date',
                  order.date,
                  Icons.calendar_month,
                  ColorsStyles.kPrimaryColor,
                ),
              ],
            ),
          ),

          // Action buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    // View details action
                    debugPrint('View details for: ${order.id}');
                  },
                  icon: const Icon(Icons.visibility),
                  label: const Text('View Details'),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    // Update status action
                    debugPrint('Update status for: ${order.id}');
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Update Status'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsStyles.kPrimaryColor,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOrderDetailRow(BuildContext context, String label, String value,
      IconData iconData, Color iconColor) {
    return Row(
      children: [
        Icon(iconData, color: iconColor, size: 20),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: FontStyles.getResponsiveFontSize(context, 14),
              color: Colors.grey.shade700,
            ),
          ),
        ),
        const Text(': '),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              fontSize: FontStyles.getResponsiveFontSize(context, 14),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Icon? _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return const Icon(Icons.done_outline_rounded, color: Colors.white);
      case 'pending':
        return const Icon(Icons.pending_outlined, color: Colors.white);
      case 'cancelled':
        return const Icon(Icons.cancel_outlined, color: Colors.white);
      case 'processing':
        return const Icon(Icons.sync, color: Colors.white);
      default:
        return null;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      case 'processing':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/colors.dart';
import 'package:restaurant_admin_panel/core/theming/font_styles.dart';

import '../../data/models/header_model.dart';
import '../../data/models/order_model.dart';

class OrdersTableTabletLayout extends StatefulWidget {
  final List<OrderModel> orders;

  const OrdersTableTabletLayout({
    super.key,
    required this.orders,
  });

  @override
  State<OrdersTableTabletLayout> createState() =>
      _OrdersTableTabletLayoutState();
}

class _OrdersTableTabletLayoutState extends State<OrdersTableTabletLayout> {
  int selectedIndex = 0;
  final List<HeaderModel> headers = [
    HeaderModel(
      text: 'Order ID',
      icon: const Icon(Icons.menu, color: Colors.purple),
    ),
    HeaderModel(
      text: 'Ordered date',
      icon: const Icon(Icons.calendar_month, color: ColorsStyles.kPrimaryColor),
    ),
    HeaderModel(
      text: 'Order Name',
      icon: const Icon(Icons.inventory, color: Colors.green),
    ),
    HeaderModel(
      text: 'Order Price',
      icon: const Icon(Icons.attach_money_outlined, color: Colors.blue),
    ),
    HeaderModel(
      text: 'Status',
      icon: Icon(Icons.show_chart, color: Colors.brown.shade900),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  void showSideSheet({
    required BuildContext context,
    required Widget child,
    bool fromRight = true, // Controls which side the sheet appears from
  }) {
    final width = MediaQuery.sizeOf(context).width * 0.5;
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return child;
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin:
                Offset(fromRight ? 1 : -1, 0), // Start from right or left edge
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          )),
          child: Align(
            alignment: fromRight ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              height: double.infinity,
              width: width,
              color: Theme.of(context).dialogBackgroundColor,
              child: child,
            ),
          ),
        );
      },
    );
  }

  Widget buildHeaderCell(HeaderModel header) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      color: Colors.blueGrey.shade500,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: header.icon,
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              header.text,
              style: TextStyle(
                fontSize: FontStyles.getResponsiveFontSize(context, 16),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDataCell(String text, {Icon? icon, void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        color: Colors.blue.shade300.withValues(alpha: 0.6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon,
              const SizedBox(width: 5),
            ],
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: FontStyles.getResponsiveFontSize(context, 16),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: _getColumnWidths(),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade700,
          ),
          children: headers.map((header) => buildHeaderCell(header)).toList(),
        ),
        ...widget.orders.map((order) => _buildOrderRow(order)),
      ],
    );
  }

  Map<int, TableColumnWidth> _getColumnWidths() {
    return {
      0: const FlexColumnWidth(1),
      1: const FlexColumnWidth(1.2),
      2: const FlexColumnWidth(1.5),
      3: const FlexColumnWidth(1),
      4: const FlexColumnWidth(1.2),
    };
  }

  TableRow _buildOrderRow(OrderModel order) {
    return TableRow(
      children: [
        buildDataCell(order.id),
        buildDataCell(order.date),
        buildDataCell(
          order.name,
          onTap: () {
            showSideSheet(
              context: context,
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #${order.id}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Date: ${order.date}'),
                      Text('Total: ${order.price}'),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Text('Status: ',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: order.status.toLowerCase() == 'delivered'
                                  ? Colors.green
                                  : order.status.toLowerCase() == 'pending'
                                      ? Colors.orange
                                      : order.status.toLowerCase() ==
                                              'cancelled'
                                          ? Colors.red
                                          : Colors.blue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              order.status,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.edit),
                            label: const Text('Edit'),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.print),
                            label: const Text('Print'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        buildDataCell(order.price),
        buildDataCell(
          order.status,
          icon: _getStatusIcon(order.status),
          onTap: () {},
        ),
      ],
    );
  }

  Icon? _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return const Icon(Icons.done_outline_rounded, color: Colors.green);
      case 'pending':
        return const Icon(Icons.pending_outlined, color: Colors.orange);
      case 'cancelled':
        return const Icon(Icons.cancel_outlined, color: Colors.red);
      case 'processing':
        return const Icon(Icons.sync, color: Colors.blue);
      default:
        return null;
    }
  }
}

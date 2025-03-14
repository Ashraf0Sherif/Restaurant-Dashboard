import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/font_styles.dart';
import 'package:restaurant_admin_panel/features/dashboard/presentation/widgets/back_ground_container.dart';

import '../../../../core/theming/colors.dart';
import '../../data/models/order_model.dart';
import '../widgets/orders_table_mobile_layout.dart';
import '../widgets/orders_table_tablet_layout.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({
    super.key,
    this.isMobile = false,
  });
  final bool isMobile;
  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final List<Widget> appBarActions = [
    const SizedBox(
      width: 20,
    ),
    IconButton(
      icon: const Icon(
        Icons.notifications_none_sharp,
        color: Colors.white,
        size: 32,
      ),
      onPressed: () {},
    ),
    const SizedBox(
      width: 20,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BackGroundContainer(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.date_range_rounded,
                    color: ColorsStyles.kPrimaryColor,
                    size: 32,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    DateTime.now().toString().substring(0, 10),
                    style: TextStyle(
                        fontSize:
                            FontStyles.getResponsiveFontSize(context, 22)),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 2,
                    child: SearchAnchor(
                      builder:
                          (BuildContext context, SearchController controller) {
                        return SearchBar(
                          controller: controller,
                          padding: const WidgetStatePropertyAll<EdgeInsets>(
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          ),
                          hintText: 'Search',
                          hintStyle: WidgetStatePropertyAll<TextStyle>(
                            TextStyle(color: Colors.grey.shade500),
                          ),
                          leading: const Icon(Icons.search, size: 21),
                          backgroundColor: const WidgetStatePropertyAll<Color>(
                              Colors.transparent),
                          elevation: const WidgetStatePropertyAll<double>(0),
                          shape: WidgetStatePropertyAll<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              side: BorderSide(color: Colors.grey.shade700),
                            ),
                          ),
                          onTap: () {
                            controller.openView();
                          },
                          onChanged: (_) {
                            controller.openView();
                          },
                        );
                      },
                      viewConstraints: const BoxConstraints(
                        maxHeight: 250,
                      ),
                      viewBackgroundColor: Colors.black12,
                      suggestionsBuilder:
                          (BuildContext context, SearchController controller) {
                        final List<String> suggestions = [
                          'Pizza',
                          'Burger',
                          'Pasta',
                          'Salad',
                          'Sandwich',
                        ]
                            .where((item) =>
                                controller.text.isEmpty ||
                                item
                                    .toLowerCase()
                                    .contains(controller.text.toLowerCase()))
                            .toList();

                        return suggestions
                            .map((suggestion) => ListTile(
                                  title: Text(suggestion),
                                  onTap: () {
                                    controller.closeView(suggestion);
                                    // Handle the selection
                                    debugPrint('Selected: $suggestion');
                                  },
                                ))
                            .toList();
                      },
                    ),
                  ),
                  ...appBarActions
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16,
            ),
          ),
          SliverToBoxAdapter(
              child: widget.isMobile
                  ? OrdersTableMobileLayout(
                      orders: orders,
                    )
                  : OrdersTableTabletLayout(
                      orders: orders,
                    ))
        ],
      ),
    );
  }
}

final List<OrderModel> orders = [
  OrderModel(
    id: '#12345',
    date: '14-12-2020',
    name: 'Pizza',
    price: '₹ 200',
    status: 'Delivered',
  ),
  OrderModel(
    id: '#12346',
    date: '15-12-2020',
    name: 'Burger',
    price: '₹ 150',
    status: 'Pending',
  ),
];

import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/features/orders/presentation/widgets/custom_orders_gridview.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({
    super.key,
  });

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
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.date_range_rounded,
                color: Colors.deepPurple,
                size: 32,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                DateTime.now().toString().substring(0, 10),
                style: const TextStyle(fontSize: 22),
              ),
              const Spacer(),
              SizedBox(
                width: 500,
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(32.0)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700),
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide:
                          BorderSide(color: Colors.grey.shade200, width: 1.5),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    hintText: 'Search',
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        size: 21,
                      ),
                    ),
                  ),
                ),
              ),
              ...appBarActions
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          //const DailyMonthlyButton(),
          const SizedBox(
            height: 16,
          ),
          //const CustomCardRow(),
          const SizedBox(
            height: 16,
          ),
          const CustomOrdersGridView()
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/features/orders/presentation/views/widgets/custom_orders_gridview.dart';

import 'widgets/custom_card_row.dart';
import 'widgets/daily_monthly_button.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({
    super.key,
  });

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final List<Widget> appBarActions = [
    const Icon(
      Icons.notifications_none_sharp,
      size: 32,
    ),
    const SizedBox(
      width: 10,
    ),
    SizedBox(
      width: 10,
      height: 50,
      child: VerticalDivider(
        color: Colors.grey.shade300,
      ),
    ),
    const SizedBox(
      width: 10,
    ),
    const Icon(
      Icons.account_circle_sharp,
      size: 32,
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
              SizedBox(
                width: 5,
              ),
              const Text(
                "June 30, 2024",
                style: TextStyle(fontSize: 22),
              ),
              const Spacer(),
              SizedBox(
                width: 500,
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    hintText: 'Search',
                    suffixIcon: Container(
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(30)),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.search,
                              size: 21,
                            ),
                          ),
                        ),
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
          const DailyMonthlyButton(),
          const SizedBox(
            height: 16,
          ),
          const CustomCardRow(),
          const SizedBox(
            height: 16,
          ),
          const CustomOrdersGridView()
          // SizedBox(
          //   width: double.infinity,
          //   child: CustomTable(),
          // )
        ],
      ),
    );
  }
}

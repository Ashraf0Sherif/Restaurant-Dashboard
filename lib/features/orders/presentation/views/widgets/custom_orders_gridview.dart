import 'package:flutter/material.dart';

class CustomOrdersGridView extends StatefulWidget {
  const CustomOrdersGridView({
    super.key,
  });

  @override
  State<CustomOrdersGridView> createState() => _CustomOrdersGridViewState();
}

class _CustomOrdersGridViewState extends State<CustomOrdersGridView> {
  int selectedIndex = 0;
  final List<String> orders = [
    "All Orders",
    "Pending Orders",
    "Delivered Orders",
    "Booked Orders",
    "Cancelled Orders"
  ];

  Widget buildOrder(String text, void Function() onPressed, int index) {
    return Column(
      children: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 3,
          width: 40,
          color: selectedIndex == index
              ? Colors.blue.shade900
              : Colors.grey.shade200,
        )
      ],
    );
  }

  Widget buildOrderInfo(String text, Icon icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: icon),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }

  Widget buildOrderDetails(String text, {Icon? icon}) {
    return Container(
      color: Colors.blue.shade50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon ?? Container(),
          icon != null
              ? const SizedBox(
                  width: 5,
                )
              : Container(),
          Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 3,
        crossAxisSpacing: 0,
        childAspectRatio: 4.5,
      ),
      children: [
        buildOrder(orders[0], () {
          setState(() {
            selectedIndex = 0;
          });
        }, 0),
        buildOrder(orders[1], () {
          setState(() {
            selectedIndex = 1;
          });
        }, 1),
        buildOrder(orders[2], () {
          setState(() {
            selectedIndex = 2;
          });
        }, 2),
        buildOrder(orders[3], () {
          setState(() {
            selectedIndex = 3;
          });
        }, 3),
        buildOrder(orders[4], () {
          setState(() {
            selectedIndex = 4;
          });
        }, 4),
        buildOrderInfo(
            "Order ID",
            const Icon(
              Icons.menu,
              color: Colors.purple,
            )),
        buildOrderInfo(
            "Ordered date",
            const Icon(
              Icons.calendar_month,
              color: Colors.orange,
            )),
        buildOrderInfo(
            "Order Name", const Icon(Icons.inventory, color: Colors.green)),
        buildOrderInfo(
            "Order Price",
            const Icon(
              Icons.attach_money_outlined,
              color: Colors.blue,
            )),
        buildOrderInfo(
            "Status",
            Icon(
              Icons.show_chart,
              color: Colors.brown.shade900,
            )),
        buildOrderDetails("#12345"),
        buildOrderDetails("14-12-2020"),
        InkWell(
            onTap: () {
              //TODO show other orders
            },
            child: buildOrderDetails("Pizza")),
        buildOrderDetails("₹ 200"),
        buildOrderDetails("Delivered",
            icon: const Icon(Icons.done_outline_rounded)),
      ],
    );
  }
}

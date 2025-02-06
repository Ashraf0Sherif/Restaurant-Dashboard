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
  // final List<String> orders = [
  //   "All Orders",
  //   "Pending Orders",
  //   "Delivered Orders",
  //   "Booked Orders",
  //   "Cancelled Orders"
  // ];

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
    return Container(
      color: Colors.blueGrey.shade500,
      child: Row(
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
      ),
    );
  }

  Widget buildOrderDetails(String text, {Icon? icon, void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.blue.shade300.withOpacity(0.6),
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
        crossAxisSpacing: 0,
        childAspectRatio: 4.5,
      ),
      children: [
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
        buildOrderDetails(
          "Pizza",
          onTap: () {
            //Show order details
          },
        ),
        buildOrderDetails("₹ 200"),
        buildOrderDetails(
          "Delivered",
          icon: const Icon(Icons.done_outline_rounded),
          onTap: () {
            //TODO change status
          },
        ),
      ],
    );
  }
}

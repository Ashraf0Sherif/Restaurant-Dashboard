import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/core/theming/spacing.dart';

class CustomTable extends StatefulWidget {
  const CustomTable({
    super.key,
  });

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  final DataRow dataRow = DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16)),
                child: const Icon(Icons.date_range, color: Colors.deepOrange)),
           horizontalSpace(5),
            const Text("Order Date"),
          ],
        ),
      ),
      DataCell(
        Row(
          children: [
            Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16)),
                child: const Icon(Icons.date_range, color: Colors.deepOrange)),
            horizontalSpace(5),
            const Text("Order Date"),
          ],
        ),
      ),
      DataCell(
        Row(
          children: [
            Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16)),
                child: const Icon(Icons.date_range, color: Colors.deepOrange)),
            horizontalSpace(5),
            const Text("Order Date"),
          ],
        ),
      ),
      DataCell(
        Row(
          children: [
            Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16)),
                child: const Icon(Icons.date_range, color: Colors.deepOrange)),
            horizontalSpace(5),
            const Text("Order Date"),
          ],
        ),
      ),
      DataCell(
        Row(
          children: [
            Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16)),
                child: const Icon(Icons.date_range, color: Colors.deepOrange)),
            horizontalSpace(5),
            const Text("Order Date"),
          ],
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return DataTable(
      dataRowColor: WidgetStateProperty.all(Colors.grey.shade100),
      dataTextStyle: const TextStyle(
        fontSize: 18,
      ),
      columns: [
        DataColumn(
          label: TextButton(
            onPressed: () {},
            child: const Text("All Orders"),
          ),
        ),
        DataColumn(
          label: TextButton(
            onPressed: () {},
            child: const Text("Pending Orders"),
          ),
        ),
        DataColumn(
          label: TextButton(
            onPressed: () {},
            child: const Text("Delivered Orders"),
          ),
        ),
        DataColumn(
          label: TextButton(
            onPressed: () {},
            child: const Text("Booked Orders"),
          ),
        ),
        DataColumn(
          label: TextButton(
            onPressed: () {},
            child: const Text("Cancelled Orders"),
          ),
        ),
      ],
      rows: [
        dataRow,
        const DataRow(
          cells: [
            DataCell(
              Text("#12345"),
            ),
            DataCell(
              Text("14-12-2020"),
            ),
            DataCell(
              Text("Order Name"),
            ),
            DataCell(
              Text("125 USD"),
            ),
            DataCell(
              Text("Delivered"),
            ),
          ],
        )
      ],
    );
  }
}

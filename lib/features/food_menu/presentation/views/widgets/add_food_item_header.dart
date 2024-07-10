import 'package:flutter/material.dart';

class AddFoodItemHeader extends StatefulWidget {
  const AddFoodItemHeader({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  State<AddFoodItemHeader> createState() => _AddFoodItemHeaderState();
}

class _AddFoodItemHeaderState extends State<AddFoodItemHeader> {
  List<String> headers = [
    "General",
    "النكهات",
    "الاحجام",
    "الاضافات",
    "Pricing",
    "Confirm",
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Row(
        children: [
          ...List.generate(
            headers.length,
            (index) {
              return Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: widget.currentIndex >= index
                            ? Colors.blue.shade900
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                        child: Text(
                      "0${index + 1}",
                      style: const TextStyle(color: Colors.white),
                    )),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(headers[index]),
                  if (index < headers.length - 1)
                    const SizedBox(
                      width: 50,
                      child: Icon(
                        Icons.arrow_right_alt,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

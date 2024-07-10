import 'package:flutter/material.dart';

import 'custom_button.dart';
class DailyMonthlyButton extends StatefulWidget {
  const DailyMonthlyButton({
    super.key,
  });

  @override
  State<DailyMonthlyButton> createState() => _DailyMonthlyButtonState();
}

class _DailyMonthlyButtonState extends State<DailyMonthlyButton> {
  bool isDaily = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Orders",
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
        SizedBox(
          width: 40,
        ),
        Container(
          width: 200,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            height: 32,
            child: Row(
              children: [
                Expanded(
                    child: CustomButton(
                        borderRadius: BorderRadius.circular(10),
                        textColor: Colors.black,
                        backgroundColor:
                        isDaily ? Colors.white : Colors.transparent,
                        text: "Daily",
                        onPressed: () {
                          setState(() {
                            isDaily = true;
                          });
                        })),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: CustomButton(
                        borderRadius: BorderRadius.circular(10),
                        textColor: Colors.black,
                        backgroundColor:
                        !isDaily ? Colors.white : Colors.transparent,
                        text: "Monthly",
                        onPressed: () {
                          setState(() {
                            isDaily = false;
                          });
                        })),
              ],
            ),
          ),
        )
      ],
    );
  }
}

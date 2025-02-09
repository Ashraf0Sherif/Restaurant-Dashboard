import 'package:flutter/material.dart';

import '../../../../core/theming/font_styles.dart';
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
            style: TextStyle(
              fontSize: FontStyles.getResponsiveFontSize(context, 36),
              fontWeight: FontWeight.bold
            )),
        const SizedBox(
          width: 40,
        ),
        Container(
          width: 200,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            height: 32,
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    borderRadius: BorderRadius.circular(10),
                    backgroundColor:
                        isDaily ? Colors.blueAccent : Colors.transparent,
                    text: Text("Daily", 
                       style: TextStyle(
                         fontSize: FontStyles.getResponsiveFontSize(context, 16)
                       )),
                    onPressed: () {
                      setState(() {
                        isDaily = true;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: CustomButton(
                        borderRadius: BorderRadius.circular(10),
                        backgroundColor:
                            !isDaily ? Colors.blueAccent : Colors.transparent,
                        text: Text("Monthly",
                             style: TextStyle(
                               fontSize: FontStyles.getResponsiveFontSize(context, 16)
                             )),
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

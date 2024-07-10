import 'package:flutter/material.dart';
import 'package:restaurant_admin_panel/features/food_menu/presentation/views/widgets/scroll_button.dart';

import 'add_item_widget.dart';
import 'custom_menu_card_title.dart';
import 'custom_menu_card_trailing.dart';

class CustomCategoryCard extends StatefulWidget {
  const CustomCategoryCard({
    super.key,
    required this.title,
    required this.itemCount,
  });

  final String title;
  final int itemCount;

  @override
  State<CustomCategoryCard> createState() => _CustomCategoryCardState();
}

class _CustomCategoryCardState extends State<CustomCategoryCard> {
  final _scrollController = ScrollController();
  final _expansionTileController = ExpansionTileController();
  bool isAtStart = true;
  bool isAtEnd = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(
      () {
        setState(
          () {
            isAtStart = _scrollController.offset <=
                _scrollController.position.minScrollExtent;
            isAtEnd = _scrollController.offset >=
                _scrollController.position.maxScrollExtent;
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ExpansionTile(
        controller: _expansionTileController,
        tilePadding: const EdgeInsets.all(20),
        title: CustomMenuCardTitle(
          title: widget.title,
          itemCount: widget.itemCount,
        ),
        trailing: CustomMenuCardTrailing(
          expansionTileController: _expansionTileController,
        ),
        children: [
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                ListView(
                  controller: _scrollController,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    const AddItemWidget(),
                    ...List.generate(
                      12,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                  color: Colors.grey.withOpacity(0.4)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: SizedBox(
                                    height: 150,
                                    child: Image.asset(
                                      "assets/images/turkey-burger-index-64873e8770b34.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                const Padding(
                                  padding: EdgeInsets.only(left: 14.0),
                                  child: Text(
                                    "Burger",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 14.0),
                                  child: Text("Contains Gluten"),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                FoodItemPricing(),
                                const Spacer(
                                  flex: 2,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
                if (!isAtEnd)
                  Align(
                    alignment: Alignment.centerRight,
                    child: ScrollButton(
                      onPressed: () {
                        _scrollController.animateTo(
                          _scrollController.offset + 600,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeIn,
                        );
                      },
                      icon: const Icon(Icons.arrow_circle_right_rounded,
                          size: 32),
                    ),
                  ),
                if (!isAtStart)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ScrollButton(
                      onPressed: () {
                        _scrollController.animateTo(
                          _scrollController.offset - 600,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeOut,
                        );
                      },
                      icon:
                          const Icon(Icons.arrow_circle_left_rounded, size: 32),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FoodItemPricing extends StatelessWidget {
  const FoodItemPricing({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "5,00 €",
              style: TextStyle(
                color: Colors.orange.shade600,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "available",
              style: TextStyle(
                color: Colors.green.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

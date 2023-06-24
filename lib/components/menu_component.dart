import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/color_theme.dart';

class MenuComponent extends StatelessWidget {
  final IconData icon;
  final String menu;
  final double ratio;

  const MenuComponent({
    Key? key,
    required this.icon,
    required this.menu,
    required this.ratio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: ratio * 15),
        Container(
          padding: const EdgeInsets.all(10),
          height: ratio * 140,
          width: ratio * 140,
          decoration: BoxDecoration(
            color: lightGrey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                size: ratio * 80,
                color: green,
              ),
              SizedBox(height: ratio * 5),
              Expanded(
                child: Center(
                  child: Text(
                    menu,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: white),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

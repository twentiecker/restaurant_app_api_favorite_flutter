import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/color_theme.dart';

class StateComponent extends StatelessWidget {
  final IconData icon;
  final String message;
  final double ratio;

  const StateComponent({
    Key? key,
    required this.icon,
    required this.message,
    required this.ratio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: white,
          size: ratio * 100,
        ),
        SizedBox(height: ratio * 5),
        Text(
          '$message!',
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(color: white),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:restaurant_app/screens/restaurant_detail.dart';
import 'package:restaurant_app/utils/color_theme.dart';

class CardComponent extends StatelessWidget {
  final Map<String, dynamic> restaurant;
  final double ratio;

  const CardComponent({
    Key? key,
    required this.restaurant,
    required this.ratio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetail.routeName,
            arguments: restaurant);
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: ratio * 120,
                height: ratio * 90,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: Image.network(
                    restaurant['pictureId'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: lightGrey,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  height: ratio * 90,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: white,
                              ),
                              SizedBox(width: ratio * 5),
                              Text(
                                restaurant['city'],
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: lightOrange,
                              ),
                              SizedBox(width: ratio * 5),
                              Text(
                                restaurant['rating']
                                    .toString()
                                    .padRight(2, '.0'),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: white),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: ratio * 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            restaurant['name'],
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: white),
                          ),
                          const Icon(
                            Icons.favorite_rounded,
                            color: green,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ratio * 10)
        ],
      ),
    );
  }
}

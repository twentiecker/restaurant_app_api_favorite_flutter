import 'package:flutter/material.dart';
import 'package:restaurant_app/components/menu_component.dart';
import 'package:restaurant_app/utils/color_theme.dart';

class RestaurantDetail extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final Map<String, dynamic> restaurant;

  const RestaurantDetail({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final ratio =
        (screenSize.width / screenSize.height) / (423.529419 / 803.137269);
    return Scaffold(
      backgroundColor: grey,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: ratio * 250,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  restaurant['pictureId'],
                  fit: BoxFit.cover,
                ),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SizedBox(height: ratio * 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: lightOrange,
                        ),
                        SizedBox(width: ratio * 5),
                        Text(
                          restaurant['rating'].toString().padRight(2, '.0'),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: white),
                        ),
                        SizedBox(width: ratio * 10),
                        Text(
                          restaurant['name'],
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: ratio * 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
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
                          .bodyMedium!
                          .copyWith(color: white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ratio * 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Description',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: white),
                ),
              ),
              SizedBox(height: ratio * 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  restaurant['description'],
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: white),
                ),
              ),
              SizedBox(height: ratio * 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Menus',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: white),
                ),
              ),
              SizedBox(height: ratio * 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Foods',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: white),
                ),
              ),
              SizedBox(height: ratio * 5),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Row(
                        children: (restaurant['menus']['foods'] as List)
                            .map((food) => MenuComponent(
                                  icon: Icons.rice_bowl_outlined,
                                  menu: food['name'],
                                  ratio: ratio,
                                ))
                            .toList()),
                    SizedBox(width: ratio * 15)
                  ],
                ),
              ),
              SizedBox(height: ratio * 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Drinks',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: white),
                ),
              ),
              SizedBox(height: ratio * 5),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Row(
                        children: (restaurant['menus']['drinks'] as List)
                            .map((drink) => MenuComponent(
                                  icon: Icons.local_drink_outlined,
                                  menu: drink['name'],
                                  ratio: ratio,
                                ))
                            .toList()),
                    SizedBox(width: ratio * 15)
                  ],
                ),
              ),
              SizedBox(height: ratio * 30),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.symmetric(vertical: 15),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: green, borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    'Confirm reservation',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: white),
                  ),
                ),
              ),
              SizedBox(height: ratio * 30)
            ],
          ),
        ),
      ),
    );
  }
}

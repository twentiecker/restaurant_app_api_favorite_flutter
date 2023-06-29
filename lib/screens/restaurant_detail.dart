import 'package:flutter/material.dart';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/components/menu_component.dart';
import 'package:restaurant_app/utils/color_theme.dart';

import '../models/detail_restaurant.dart';

class RestaurantDetail extends StatefulWidget {
  static const routeName = '/restaurant_detail';
  final String id;

  const RestaurantDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<RestaurantDetail> createState() => _RestaurantDetailState();
}

class _RestaurantDetailState extends State<RestaurantDetail> {
  late Future<DetailRestaurant> _detailRestaurant;

  @override
  void initState() {
    super.initState();
    _detailRestaurant = ApiService().detailRestaurant(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final ratio =
        (screenSize.width / screenSize.height) / (423.529419 / 803.137269);
    return Scaffold(
      backgroundColor: grey,
      body: FutureBuilder<DetailRestaurant>(
        future: _detailRestaurant,
        builder:
            (BuildContext context, AsyncSnapshot<DetailRestaurant> snapshot) {
          var state = snapshot.connectionState;
          if (state != ConnectionState.done) {
            return const Column(
              children: [
                Expanded(child: Center(child: CircularProgressIndicator())),
              ],
            );
          } else {
            if (snapshot.hasData) {
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: ratio * 250,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.network(
                          'https://restaurant-api.dicoding.dev/images/small/${snapshot.data!.restaurant.pictureId}',
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
                                  snapshot.data!.restaurant.rating
                                      .toString()
                                      .padRight(2, '.0'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: white),
                                ),
                                SizedBox(width: ratio * 10),
                                Text(
                                  snapshot.data!.restaurant.name,
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
                              snapshot.data!.restaurant.city,
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
                          snapshot.data!.restaurant.description,
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
                                children: snapshot.data!.restaurant.menus.foods
                                    .map((food) => MenuComponent(
                                          icon: Icons.rice_bowl_outlined,
                                          menu: food.name,
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
                                children: snapshot.data!.restaurant.menus.drinks
                                    .map((drink) => MenuComponent(
                                          icon: Icons.local_drink_outlined,
                                          menu: drink.name,
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
                            color: green,
                            borderRadius: BorderRadius.circular(5)),
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
              );
            } else if (snapshot.hasError) {
              return Column(
                children: [
                  Expanded(
                      child: Center(child: Text(snapshot.error.toString()))),
                ],
              );
            } else {
              return const Center(
                child: Column(
                  children: [
                    Expanded(child: Text('')),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/card_component.dart';
import 'package:restaurant_app/components/state_component.dart';
import 'package:restaurant_app/provider/search_restaurant_provider.dart';
import 'package:restaurant_app/utils/color_theme.dart';

import '../models/list_restaurant.dart';
import '../utils/result_state.dart';

class RestaurantSearch extends StatelessWidget {
  static const routeName = '/restaurant_search';

  const RestaurantSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final ratio =
        (screenSize.width / screenSize.height) / (423.529419 / 803.137269);
    return Scaffold(
      backgroundColor: grey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ratio * 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: const EdgeInsets.all(0),
                    alignment: Alignment.centerLeft,
                    backgroundColor: grey,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.white,
                  )),
              Text(
                'Search',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: green),
              ),
              SizedBox(height: ratio * 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: lightGrey,
                    shape: BoxShape.rectangle,
                    border: Border.all(color: green),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search by name/category/menu',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white30)),
                  onChanged: (String value) {
                    Provider.of<SearchRestaurantProvider>(context,
                            listen: false)
                        .query = value;
                    Provider.of<SearchRestaurantProvider>(context,
                            listen: false)
                        .search(value);
                  },
                ),
              ),
              SizedBox(height: ratio * 30),
              Consumer<SearchRestaurantProvider>(
                builder: (context, state, _) {
                  if (state.state == ResultState.loading) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state.state == ResultState.hasData) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: state.result.restaurants.map((restaurant) {
                            final Restaurant listSearchRestaurant = Restaurant(
                              id: restaurant.id,
                              name: restaurant.name,
                              description: restaurant.description,
                              pictureId: restaurant.pictureId,
                              city: restaurant.city,
                              rating: restaurant.rating,
                            );
                            return CardComponent(
                              restaurant: listSearchRestaurant,
                              ratio: ratio,
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  } else if (state.state == ResultState.noData) {
                    return Expanded(
                      child: Center(
                        child: StateComponent(
                          icon: Icons.not_interested_rounded,
                          message: state.message,
                          ratio: ratio,
                        ),
                      ),
                    );
                  } else if (state.state == ResultState.error) {
                    return Expanded(
                      child: Center(
                        child: StateComponent(
                          icon:
                              Icons.signal_wifi_connected_no_internet_4_rounded,
                          message: 'No Internet Connection',
                          ratio: ratio,
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Expanded(
                        child: Text(''),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: ratio * 20)
            ],
          ),
        ),
      ),
    );
  }
}

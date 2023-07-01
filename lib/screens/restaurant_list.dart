import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/state_component.dart';
import 'package:restaurant_app/provider/list_restaurant_provider.dart';
import 'package:restaurant_app/screens/restaurant_search.dart';
import 'package:restaurant_app/utils/color_theme.dart';

import '../components/card_component.dart';

class RestaurantList extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const RestaurantList({Key? key}) : super(key: key);

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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: grey,
                        minimumSize: const Size.square(25),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RestaurantSearch.routeName);
                      },
                      child: const Icon(
                        Icons.search_sharp,
                        color: Colors.white,
                      )),
                ],
              ),
              Text(
                'Restaurant',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: green),
              ),
              SizedBox(height: ratio * 10),
              Text(
                'Recommendation restaurant for you!',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: white),
              ),
              SizedBox(height: ratio * 30),
              Consumer<ListRestaurantProvider>(
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
                          children: state.result.restaurants
                              .map((restaurant) => CardComponent(
                                    restaurant: restaurant,
                                    ratio: ratio,
                                  ))
                              .toList(),
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

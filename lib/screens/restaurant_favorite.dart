import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/state_component.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/screens/restaurant_search.dart';
import 'package:restaurant_app/utils/color_theme.dart';

import '../components/card_component.dart';
import '../utils/result_state.dart';

class RestaurantFavorite extends StatelessWidget {
  static const routeName = '/restaurant_favorite';

  const RestaurantFavorite({Key? key}) : super(key: key);

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_sharp,
                      color: Colors.white,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RestaurantSearch.routeName,
                      );
                    },
                    child: const Icon(
                      Icons.search_sharp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: ratio * 20),
              Text(
                'Favorites',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: green),
              ),
              SizedBox(height: ratio * 10),
              Text(
                'List of your favorite restaurants!',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: white),
              ),
              SizedBox(height: ratio * 30),
              Consumer<DatabaseProvider>(
                builder: (context, provider, _) {
                  if (provider.state == ResultState.hasData) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: provider.bookmarks
                              .map((restaurant) => CardComponent(
                                    restaurant: restaurant,
                                    ratio: ratio,
                                  ))
                              .toList(),
                        ),
                      ),
                    );
                  } else if (provider.state == ResultState.noData) {
                    return Expanded(
                      child: Center(
                        child: StateComponent(
                          icon: Icons.not_interested_rounded,
                          message: provider.message,
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

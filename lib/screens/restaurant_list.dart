import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/state_component.dart';
import 'package:restaurant_app/provider/list_restaurant_provider.dart';
import 'package:restaurant_app/screens/restaurant_detail.dart';
import 'package:restaurant_app/screens/restaurant_favorite.dart';
import 'package:restaurant_app/screens/restaurant_search.dart';
import 'package:restaurant_app/screens/settings_page.dart';
import 'package:restaurant_app/utils/color_theme.dart';

import '../components/card_component.dart';
import '../utils/notification_helper.dart';
import '../utils/result_state.dart';

class RestaurantList extends StatefulWidget {
  static const routeName = '/restaurant_list';

  const RestaurantList({Key? key}) : super(key: key);

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
      context,
      RestaurantDetail.routeName,
    );
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

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
                  SizedBox(width: ratio * 20),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RestaurantFavorite.routeName,
                      );
                    },
                    child: const Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: ratio * 20),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        SettingsPage.routeName,
                      );
                    },
                    child: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: ratio * 20),
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

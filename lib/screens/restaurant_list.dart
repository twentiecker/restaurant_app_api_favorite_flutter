import 'package:flutter/material.dart';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/screens/restaurant_search.dart';
import 'package:restaurant_app/utils/color_theme.dart';

import '../components/card_component.dart';
import '../models/list_restaurant.dart';

class RestaurantList extends StatefulWidget {
  static const routeName = '/restaurant_list';

  const RestaurantList({Key? key}) : super(key: key);

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  late Future<ListRestaurant> _listRestaurant;

  @override
  void initState() {
    super.initState();
    _listRestaurant = ApiService().listRestaurant();
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
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          backgroundColor: grey,
                          minimumSize: Size.square(25),),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RestaurantSearch.routeName);
                      },
                      child: Icon(
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
              FutureBuilder<ListRestaurant>(
                  future: _listRestaurant,
                  builder: (context, AsyncSnapshot<ListRestaurant> snapshot) {
                    var state = snapshot.connectionState;
                    if (state != ConnectionState.done) {
                      return const Expanded(
                          child: Center(child: CircularProgressIndicator()));
                    } else {
                      if (snapshot.hasData) {
                        return Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: snapshot.data!.restaurants
                                  .map((restaurant) => CardComponent(
                                        restaurant: restaurant,
                                        ratio: ratio,
                                      ))
                                  .toList(),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Expanded(
                            child:
                                Center(child: Text(snapshot.error.toString())));
                      } else {
                        return const Center(
                          child: Expanded(child: Text('')),
                        );
                      }
                    }
                  }),
              SizedBox(height: ratio * 20)
            ],
          ),
        ),
      ),
    );
  }
}

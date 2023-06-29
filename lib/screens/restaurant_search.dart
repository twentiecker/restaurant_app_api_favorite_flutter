import 'package:flutter/material.dart';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/components/search_component.dart';
import 'package:restaurant_app/utils/color_theme.dart';

import '../models/search_restaurant.dart';

class RestaurantSearch extends StatefulWidget {
  static const routeName = '/restaurant_search';

  const RestaurantSearch({Key? key}) : super(key: key);

  @override
  State<RestaurantSearch> createState() => _RestaurantSearchState();
}

class _RestaurantSearchState extends State<RestaurantSearch> {
  late Future<SearchRestaurant> _searchRestaurant;
  String _keyWord = '';
  String _temp = '';
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchRestaurant = ApiService().searchRestaurant(_keyWord);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;
    final ratio =
        (screenSize.width / screenSize.height) / (423.529419 / 803.137269);

    if (_keyWord != _temp) {
      _temp = _keyWord;
      _isSearching = true;
    } else {
      _isSearching = false;
    }

    if (_isSearching) {
      _searchRestaurant = ApiService().searchRestaurant(_keyWord);
    }

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
                    padding: EdgeInsets.all(0),
                    alignment: Alignment.centerLeft,
                    backgroundColor: grey,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.white,
                  )),
              Text(
                'Search',
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: green),
              ),
              SizedBox(height: ratio * 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: lightGrey,
                    shape: BoxShape.rectangle,
                    border: Border.all(color: green),
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search by name/category/menu',
                      hintStyle: Theme
                          .of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white30)),
                  onChanged: (String value) {
                    setState(() {
                      _keyWord = value;
                    });
                  },
                ),
              ),
              SizedBox(height: ratio * 30),
              FutureBuilder<SearchRestaurant>(
                  future: _searchRestaurant,
                  builder: (context, AsyncSnapshot<SearchRestaurant> snapshot) {
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
                                  .map((restaurant) =>
                                  SearchComponent(
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

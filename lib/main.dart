import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/list_restaurant_provider.dart';
import 'package:restaurant_app/provider/search_restaurant_provider.dart';

import 'package:restaurant_app/screens/restaurant_detail.dart';
import 'package:restaurant_app/screens/restaurant_favorite.dart';
import 'package:restaurant_app/screens/restaurant_list.dart';
import 'package:restaurant_app/screens/restaurant_search.dart';
import 'package:restaurant_app/utils/pallete_theme.dart';
import 'package:restaurant_app/utils/roboto_theme.dart';

import 'database/database_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) =>
              ListRestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) =>
              SearchRestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) =>
              DatabaseProvider(databaseHelper: DatabaseHelper()),
        )
      ],
      child: MaterialApp(
        title: 'Restaurant App',
        theme: ThemeData(
          textTheme: robotoTheme,
          primarySwatch: PaletteTheme.kToDark,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: RestaurantList.routeName,
        routes: {
          RestaurantList.routeName: (context) => const RestaurantList(),
          RestaurantDetail.routeName: (context) => RestaurantDetail(
              id: ModalRoute.of(context)?.settings.arguments as String),
          RestaurantSearch.routeName: (context) => const RestaurantSearch(),
          RestaurantFavorite.routeName: (context) => const RestaurantFavorite()
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:restaurant_app/screens/restaurant_detail.dart';
import 'package:restaurant_app/screens/restaurant_list.dart';
import 'package:restaurant_app/screens/restaurant_search.dart';
import 'package:restaurant_app/utils/pallete_theme.dart';
import 'package:restaurant_app/utils/roboto_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
              id: ModalRoute.of(context)?.settings.arguments as String,
            ),
        RestaurantSearch.routeName: (context) => RestaurantSearch()
      },
    );
  }
}

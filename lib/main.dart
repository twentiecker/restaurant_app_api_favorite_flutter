import 'package:flutter/material.dart';

// import 'package:restaurant_app/models/local_restaurant.dart';
import 'package:restaurant_app/screens/restaurant_detail.dart';
import 'package:restaurant_app/screens/restaurant_detail_api.dart';
import 'package:restaurant_app/screens/restaurant_list.dart';
import 'package:restaurant_app/screens/restaurant_list_api.dart';
import 'package:restaurant_app/utils/pallete_theme.dart';
import 'package:restaurant_app/utils/roboto_theme.dart';

import 'models/detail_restaurant.dart';

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
      initialRoute: RestaurantListApi.routeName,
      routes: {
        RestaurantListApi.routeName: (context) => const RestaurantListApi(),
        RestaurantDetailApi.routeName: (context) => RestaurantDetailApi(
              id: ModalRoute.of(context)?.settings.arguments as String,
            )
      },
    );
  }
}

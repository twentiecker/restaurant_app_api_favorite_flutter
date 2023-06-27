// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:restaurant_app/models/local_restaurant.dart';
// import 'package:restaurant_app/utils/color_theme.dart';
//
// import '../components/card_component.dart';
//
// class RestaurantList extends StatelessWidget {
//   static const routeName = '/restaurant_list';
//
//   const RestaurantList({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Size screenSize = MediaQuery.of(context).size;
//     final ratio =
//         (screenSize.width / screenSize.height) / (423.529419 / 803.137269);
//     return Scaffold(
//       backgroundColor: grey,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             children: [
//               SizedBox(height: ratio * 20),
//               Text(
//                 'Restaurant',
//                 style: Theme.of(context)
//                     .textTheme
//                     .headlineMedium!
//                     .copyWith(color: green),
//               ),
//               SizedBox(height: ratio * 10),
//               Text(
//                 'Recommendation restaurant for you!',
//                 style: Theme.of(context)
//                     .textTheme
//                     .titleMedium!
//                     .copyWith(color: white),
//               ),
//               SizedBox(height: ratio * 30),
//               FutureBuilder(
//                   future: DefaultAssetBundle.of(context)
//                       .loadString('assets/local_restaurant.json'),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       final locaRestaurant = LocalRestaurant.fromJson(
//                           jsonDecode(snapshot.data.toString()));
//                       return Expanded(
//                         child: SingleChildScrollView(
//                           child: Column(
//                               children: locaRestaurant.restaurants
//                                   .map((restaurant) => CardComponent(
//                                         restaurant: restaurant,
//                                         ratio: ratio,
//                                       ))
//                                   .toList()),
//                         ),
//                       );
//                     } else {
//                       return const CircularProgressIndicator();
//                     }
//                   }),
//               SizedBox(height: ratio * 20)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

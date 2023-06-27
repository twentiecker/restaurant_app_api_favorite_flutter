import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/models/list_restaurant.dart';

import '../models/detail_restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  // static const String _apiKey = 'YOUR_API_KEY';
  // static const String _category = 'business';
  // static const String _country = 'id';

  Future<ListRestaurant> listRestaurant() async {
    final response = await http.get(Uri.parse('$_baseUrl/list'));
    if (response.statusCode == 200) {
      return ListRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }

  Future<DetailRestaurant> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/detail/$id'));
    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }
}

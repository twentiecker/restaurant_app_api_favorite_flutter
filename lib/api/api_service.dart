import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/models/list_restaurant.dart';

import '../models/detail_restaurant.dart';
import '../models/search_restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<ListRestaurant> listRestaurant(http.Client client) async {
    final response = await client.get(Uri.parse('$_baseUrl/list'));
    if (response.statusCode == 200) {
      return ListRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }

  Future<DetailRestaurant> detailRestaurant(
    http.Client client,
    String id,
  ) async {
    final response = await client.get(Uri.parse('$_baseUrl/detail/$id'));
    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<SearchRestaurant> searchRestaurant(
    http.Client client,
    String query,
  ) async {
    final response = await client.get(Uri.parse('$_baseUrl/search?q=$query'));
    if (response.statusCode == 200) {
      return SearchRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load search restaurant');
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:restaurant_app/api/api_service.dart';

import '../models/search_restaurant.dart';
import '../utils/result_state.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  String query;

  SearchRestaurantProvider({
    required this.apiService,
    this.query = '',
  }) {
    _fetchAllSearchRestaurant(query);
  }

  late SearchRestaurant _searchRestaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  SearchRestaurant get result => _searchRestaurant;

  ResultState get state => _state;

  Future<dynamic> _fetchAllSearchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final searchRestaurant = await apiService.searchRestaurant(query);
      if (searchRestaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _searchRestaurant = searchRestaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  void search(String keyWord) {
    query = keyWord;
    _fetchAllSearchRestaurant(keyWord);
    notifyListeners();
  }
}

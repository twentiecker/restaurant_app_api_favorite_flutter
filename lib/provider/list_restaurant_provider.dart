import 'package:flutter/foundation.dart';
import 'package:restaurant_app/api/api_service.dart';

import '../models/list_restaurant.dart';
import '../utils/result_state.dart';

class ListRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  ListRestaurantProvider({required this.apiService}) {
    _fetchAllListRestaurant();
  }

  late ListRestaurant _listRestaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  ListRestaurant get result => _listRestaurant;

  ResultState get state => _state;

  Future<dynamic> _fetchAllListRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final listRestaurant = await apiService.listRestaurant();
      if (listRestaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _listRestaurant = listRestaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}

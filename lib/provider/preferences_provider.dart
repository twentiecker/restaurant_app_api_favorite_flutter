import 'package:flutter/cupertino.dart';

import '../preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyRestaurantsPreferences();
  }

  bool _isDailyRestaurantsActive = false;

  bool get isDailyRestaurantsActive => _isDailyRestaurantsActive;

  void _getDailyRestaurantsPreferences() async {
    _isDailyRestaurantsActive =
        await preferencesHelper.isDailyRestaurantsActive;
    notifyListeners();
  }

  void enableDailyRestaurants(bool value) {
    preferencesHelper.setDailyRestaurants(value);
    _getDailyRestaurantsPreferences();
  }
}

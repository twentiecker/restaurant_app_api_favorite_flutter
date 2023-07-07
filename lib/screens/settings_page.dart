import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/platform_widget.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/utils/color_theme.dart';

import '../custom_dialog.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/restaurant_settings';

  const SettingsPage({Key? key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: grey,
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final ratio =
        (screenSize.width / screenSize.height) / (423.529419 / 803.137269);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ratio * 20),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_sharp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: ratio * 20),
            Text(
              'Settings',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: green),
            ),
            SizedBox(height: ratio * 20),
            Expanded(
              child: Consumer<PreferencesProvider>(
                builder: (context, provider, child) {
                  return ListView(
                    children: [
                      Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: lightGrey,
                        child: ListTile(
                          title: Text(
                            'Scheduling Restaurants',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: white),
                          ),
                          trailing: Consumer<SchedulingProvider>(
                            builder: (context, scheduled, _) {
                              return Switch.adaptive(
                                activeColor: green,
                                value: provider.isDailyRestaurantsActive,
                                onChanged: (value) async {
                                  if (Platform.isIOS) {
                                    customDialog(context);
                                  } else {
                                    scheduled.scheduledRestaurants(value);
                                    provider.enableDailyRestaurants(value);
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/models/detail_restaurant.dart';

import 'detail_restaurant_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  const String baseUrl = 'https://restaurant-api.dicoding.dev';

  group('detailRestaurant', () {
    const String id = 'id';
    test('returns an DetailRestaurant if the http call completes successfully',
        () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('$baseUrl/detail/$id'))).thenAnswer((_) async =>
          http.Response(
              '{"error": false,"message": "success","restaurant": {"id": "rqdv5juczeskfw1e867","name": "Melting Pot","description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...","city": "Medan","address": "Jln. Pandeglang no 19","pictureId": "14","categories": [{"name": "Italia"},{"name": "Modern"}],"menus": {"foods": [{"name": "Paket rosemary"},{"name": "Toastie salmon"}],"drinks": [{"name": "Es krim"},{"name": "Sirup"}]},"rating": 4.2,"customerReviews": [{"name": "Ahmad","review": "Tidak rekomendasi untuk pelajar!","date": "13 November 2019"}]}}',
              200));

      expect(await ApiService().detailRestaurant(client, id),
          isA<DetailRestaurant>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('$baseUrl/detail/$id')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(ApiService().detailRestaurant(client, id), throwsException);
    });
  });
}

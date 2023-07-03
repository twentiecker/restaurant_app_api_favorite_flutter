import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/models/search_restaurant.dart';

import 'detail_restaurant_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  const String baseUrl = 'https://restaurant-api.dicoding.dev';
  const String query = 'query';

  group('searchRestaurant', () {
    test('returns an SearchRestaurant if the http call completes successfully',
        () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('$baseUrl/search?q=$query'))).thenAnswer(
          (_) async => http.Response(
              '{"error": false,"founded": 1,"restaurants": [{"id": "fnfn8mytkpmkfw1e867","name": "Makan mudah","description": "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, ...","pictureId": "22","city": "Medan","rating": 3.7}]}',
              200));

      expect(await ApiService().searchRestaurant(client, query),
          isA<SearchRestaurant>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('$baseUrl/search?q=$query')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(ApiService().searchRestaurant(client, query), throwsException);
    });
  });
}

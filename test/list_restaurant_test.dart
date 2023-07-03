import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/api/api_service.dart';
import 'package:restaurant_app/models/list_restaurant.dart';
import 'list_restaurant_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  const String baseUrl = 'https://restaurant-api.dicoding.dev';

  group('listRestaurant', () {
    test('returns an ListRestaurant if the http call completes successfully',
        () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('$baseUrl/list'))).thenAnswer((_) async =>
          http.Response(
              '{"error": false,"message": "success","count": 20,"restaurants": [{"id": "rqdv5juczeskfw1e867","name": "Melting Pot","description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...","pictureId": "14","city": "Medan","rating": 4.2},{"id": "s1knt6za9kkfw1e867","name": "Kafe Kita","description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...","pictureId": "25","city": "Gorontalo","rating": 4}]}',
              200));

      expect(await ApiService().listRestaurant(client), isA<ListRestaurant>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('$baseUrl/list')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(ApiService().listRestaurant(client), throwsException);
    });
  });
}

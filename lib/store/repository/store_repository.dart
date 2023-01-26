import 'package:store/store/store.dart';
import 'package:dio/dio.dart';

class StoreRepository {
  final Dio _client = Dio(BaseOptions(
    baseUrl: 'https://fakestoreapi.com/products',
  ));

  Future<List<Product>> getProducts() async {
    final response = await _client.get('');
    return (response.data as List)
        .map((json) => Product(
              id: json['id'],
              title: json['title'],
              image: json['image'],
            ))
        .toList();
  }
}

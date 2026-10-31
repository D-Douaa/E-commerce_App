import 'package:e_commerce/core/network/dio_client.dart';
import 'package:e_commerce/features/products/data/models/product_model.dart';
class ProductsRemoteDataSource {
final DioClient dioClient;

ProductsRemoteDataSource({required this.dioClient});
Future<List<ProductModel>> getProducts() async {
  final response = await dioClient.get(
  'products',
  requiresAuth: false,
);
final productsJson = response.data['products'];
return productsJson.map<ProductModel>(
  (item) => ProductModel.fromJson(item),
).toList();

}
}

import 'package:e_commerce/core/network/dio_client.dart';
import 'package:e_commerce/features/products/data/models/product_model.dart';
class ProductDetailsRemoteDataSource {
  final  DioClient dioClient;
ProductDetailsRemoteDataSource({required this.dioClient});
  
Future<ProductModel> getProductDetails (String id)async{
  final response= await dioClient.get('products/$id', requiresAuth: false);
  return ProductModel.fromJson(response.data);
}
  
  
}
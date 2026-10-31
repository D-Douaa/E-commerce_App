import 'package:e_commerce/features/products/data/datasources/product_details_remote_data_source.dart';
import 'package:e_commerce/features/products/presentation/cubit/product_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductDetailsRemoteDataSource dataSource;

  ProductDetailsCubit({
    required this.dataSource,
  }) : super(ProductDetailsInitial());
  Future<void>getProductDetails(String id)async{
    emit(ProductDetailsLoading());
    try{
      final product=await dataSource.getProductDetails(id);
      emit(ProductDetailsSuccess(product));}
      catch(e){
        emit(ProductDetailsError(e.toString()));
    }
  }
}
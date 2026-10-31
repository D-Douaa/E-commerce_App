import 'package:e_commerce/features/products/data/datasources/products_remote_data_source.dart';
import 'package:e_commerce/features/products/presentation/cubit/products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRemoteDataSource dataSource;

  ProductsCubit({required this.dataSource}) : super(ProductsInitial());
  Future<void> getProducts() async {
    emit(ProductsLoading());
    try {
      final products = await dataSource.getProducts();
      emit(ProductsSuccess(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}

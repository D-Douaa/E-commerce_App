

import 'package:e_commerce/features/products/presentation/cubit/product_rating_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductRatingCubit extends Cubit<ProductRatingState>{
ProductRatingCubit():super(ProductRatingInitial());
void selectRating(int rating){
  emit(ProductRatingSelected(rating));
}
void submitRating(){
  if(state is ProductRatingSelected){
    final selectedState=state as ProductRatingSelected;
    emit(ProductRatingSubmitted(selectedState.rating));
  }
}
}
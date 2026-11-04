abstract class ProductRatingState {}

class ProductRatingInitial extends ProductRatingState {}

class ProductRatingSelected extends ProductRatingState {
  final int rating;

  ProductRatingSelected(this.rating);
}

class ProductRatingSubmitted extends ProductRatingState {
  final int rating;

  ProductRatingSubmitted(this.rating);
}
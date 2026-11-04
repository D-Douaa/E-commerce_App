import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/product_rating_cubit.dart';
import '../cubit/product_rating_state.dart';

class ProductRatingSection extends StatelessWidget {
  const ProductRatingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductRatingCubit(),
      child: BlocBuilder<ProductRatingCubit, ProductRatingState>(
        builder: (context, state) {
          int selectedRating = 0;
          bool isSubmitted = false;

          if (state is ProductRatingSelected) {
            selectedRating = state.rating;
          }

          if (state is ProductRatingSubmitted) {
            selectedRating = state.rating;
            isSubmitted = true;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Rate This Product',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF223263),
                ),
              ),
              const SizedBox(height: 12),

              Row(
                children: List.generate(5, (index) {
                  final rating = index + 1;

                  return IconButton(
                    onPressed: isSubmitted
                        ? null
                        : () {
                            context
                                .read<ProductRatingCubit>()
                                .selectRating(rating);
                          },
                    icon: Icon(
                      rating <= selectedRating
                          ? Icons.star
                          : Icons.star_border,
                      color: const Color(0xFFFFC833),
                      size: 30,
                    ),
                  );
                }),
              ),

              const SizedBox(height: 8),

              if (isSubmitted)
                Text(
                  'Thank you! Your rating: $selectedRating/5',
                  style: const TextStyle(
                    color: Color(0xFF40BFFF),
                    fontWeight: FontWeight.w600,
                  ),
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectedRating == 0
                        ? null
                        : () {
                            context
                                .read<ProductRatingCubit>()
                                .submitRating();
                          },
                    child: const Text('Submit Rating'),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:e_commerce/core/network/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/product_details_remote_data_source.dart';
import '../cubit/product_details_cubit.dart';
import '../cubit/product_details_state.dart';
import '../widgets/product_image_slider.dart';

class ProductDetailsView extends StatefulWidget {
  final String productId;

  const ProductDetailsView({
    super.key,
    required this.productId,
  });

  static const Color navy = Color(0xFF223263);
  static const Color blue = Color(0xFF40BFFF);
  static const Color grey = Color(0xFF9098B1);

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  String selectedSize = 'M';
  double get imageHeight {
    switch (selectedSize) {
      case 'S':
        return 220;
      case 'M':
        return 260;
      case 'L':
        return 300;
      case 'XL':
        return 340;
      default:
        return 260;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: ProductDetailsView.navy),
        ),
        title: const Text(
          'Product Details',
          style: TextStyle(
            color: ProductDetailsView.navy,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => ProductDetailsCubit(
          dataSource: ProductDetailsRemoteDataSource(
            dioClient: DioClient.instance,
          ),
        )..getProductDetails(widget.productId),
        child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (state is ProductDetailsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: ProductDetailsView.blue),
              );
            }

            if (state is ProductDetailsError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: ProductDetailsView.navy),
                ),
              );
            }

            if (state is ProductDetailsSuccess) {
              final product = state.product;
              final hasDiscount =
                  product.discountPrice < product.price;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     ProductImageSlider(
  images: product.images,
  height: imageHeight,
),
                      const SizedBox(height: 20),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: ProductDetailsView.navy,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.favorite_border,
                            color: ProductDetailsView.navy,
                            size: 24,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Color(0xFFFFC833),
                            size: 22,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            product.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              color: ProductDetailsView.navy,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Text(
                            '\$${product.discountPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: hasDiscount ? ProductDetailsView.blue : ProductDetailsView.navy,
                            ),
                          ),
                          if (hasDiscount) ...[
                            const SizedBox(width: 12),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: ProductDetailsView.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 16),

                      Text(
                        product.description,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: ProductDetailsView.grey,
                        ),
                      ),
                      const SizedBox(height: 24),
const Text(
  'Select Size',
  style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: ProductDetailsView.navy,
  ),
),
const SizedBox(height: 12),

Wrap(
  spacing: 12,
  children: ['S', 'M', 'L', 'XL'].map((size) {
    final isSelected = selectedSize == size;

    return ChoiceChip(
      label: Text(size),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          selectedSize = size;
        });
      },
      selectedColor: ProductDetailsView.blue,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : ProductDetailsView.navy,
      ),
    );
  }).toList(),
),

const SizedBox(height: 24),
                      const Text(
                        'Select Color',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ProductDetailsView.navy,
                        ),
                      ),
                      const SizedBox(height: 16),

                      const Wrap(
                        spacing: 16,
                        runSpacing: 12,
                        children: [
                          _ColorOption(color: Color(0xFFFFC833)),
                          _ColorOption(color: Color(0xFF40BFFF)),
                          _ColorOption(color: Color(0xFFFB7181)),
                          _ColorOption(color: Color(0xFF53D1B6)),
                          _ColorOption(color: Color(0xFF6C61F5)),
                          _ColorOption(color: Color(0xFF223263)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: ProductDetailsView.blue,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              'Add To Cart',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorOption extends StatelessWidget {
  final Color color;

  const _ColorOption({
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
    );
  }
}

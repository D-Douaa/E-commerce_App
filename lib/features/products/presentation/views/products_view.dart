import 'package:e_commerce/features/favorites/presentation/views/favorites_view.dart';
import 'package:e_commerce/features/favorites/presentation/views/offers_view.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/responsive/responsive_context.dart';
import '../widgets/product_card.dart';
import '../widgets/category_item.dart';
import 'product_details_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/core/network/dio_client.dart';
import 'package:e_commerce/features/products/data/datasources/products_remote_data_source.dart';
import 'package:e_commerce/features/products/presentation/cubit/products_cubit.dart';
import 'package:e_commerce/features/products/presentation/cubit/products_state.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    //make size
    //is mobile=  context.responsive(mobile: );
    return BlocProvider(
      create: (context) => ProductsCubit(
        dataSource: ProductsRemoteDataSource(
          dioClient: DioClient(),
        ),
      )..getProducts(),
      child:Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Search Bar
                  Padding(
                    padding: EdgeInsets.all(context.spacing.md),
                    child: Row(
                      children: [
                        const Expanded(
                          child: AppTextField(
                            hintText: 'Search Product',
                            prefixIcon: Icons.search,
                          ),
                        ),
                        SizedBox(width: context.spacing.md),
                        IconButton(
                          icon: const Icon(
                            Icons.favorite_border,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritesView()));},
                        ),
                        
IconButton(
  icon: const Icon(
    Icons.local_offer_outlined,
    color: AppColors.textSecondary,
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OffersView(),
      ),
    );
  },
),

                        IconButton(
                          icon: const Icon(
                            Icons.notifications_none,
                            color: AppColors.textSecondary,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),

                  // Categories Section
                  //make padding based on typw of screen mobile or tablet
                  Padding(
                    // make copywith
                    padding: EdgeInsets.symmetric(
                      horizontal: context.responsive(
                        mobile: 16.0,
                        tablet: 40.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Category', style: context.textStyles.heading4),
                        Flexible(
                          child: Text(
                            'More Category',
                            style: context.textStyles.heading4.copyWith(
                              color: AppColors.primary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: context.spacing.md),
                  //to do: change to list view
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(
                      horizontal: context.spacing.md,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CategoryItem(
                          icon: Icons.checkroom,
                          title: 'Shirt',
                        ),
                        SizedBox(width: context.spacing.md),
                        const CategoryItem(
                          icon: Icons.work_outline,
                          title: 'Bag',
                        ),
                        SizedBox(width: context.spacing.md),
                        const CategoryItem(
                          icon: Icons.computer,
                          title: 'Equipment',
                        ),
                        SizedBox(width: context.spacing.md),
                        const CategoryItem(icon: Icons.watch, title: 'Watch'),
                        SizedBox(width: context.spacing.md),
                        const CategoryItem(
                          icon: Icons.diamond,
                          title: 'Jewelry',
                        ),
                      ],
                    ),
                  ),

                  // Products Section
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.spacing.md,
                      vertical: context.spacing.md,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Flash Sale', style: context.textStyles.heading4),
                        Flexible(
                          child: Text(
                            'See More',
                            style: context.textStyles.heading4.copyWith(
                              color: AppColors.primary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<ProductsCubit, ProductsState>(
  builder: (context, state) {
    if (state is ProductsLoading) {
      return const SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
if (state is ProductsSuccess) {
  final products = state.products;

  return SliverPadding(
    padding: EdgeInsets.symmetric(
      horizontal: context.spacing.md,
    ),
    sliver: SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: context.responsive(
          mobile: 2,
          tablet: 4,
          desktop: 6,
        ),
        mainAxisSpacing: context.spacing.md,
        crossAxisSpacing: context.spacing.md,
        childAspectRatio: context.responsive(
          mobile: 0.65,
          tablet: 0.7,
          desktop: 0.75,
        ),
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final product=products[index];
          return ProductCard(product:product,onTap:() => Navigator.push(context, MaterialPageRoute(builder:(context) => ProductDetailsView(productId: product.id.toString()))));
        },
        childCount: products.length,
      ),
    ),
  );
}
if (state is ProductsError) {
  return SliverToBoxAdapter(
    child: Center(
      child: Text('Error: ${state.message}'),
    ),
  );
}
    return const SliverToBoxAdapter(
      child: SizedBox.shrink(),
    );
  },
),
           
            SliverToBoxAdapter(child: SizedBox(height: context.spacing.xxl)),
          ],
        ),
      ),
      ),
    );
  }
}

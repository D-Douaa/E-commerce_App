import 'package:e_commerce/features/navigation/presentation/views/main_navigation_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/auth/presentation/views/login.dart';
import '../../features/products/presentation/views/products_view.dart';
import '../../features/products/presentation/views/product_details_view.dart';
import '../../features/favorites/presentation/views/favorites_view.dart';
import '../../features/favorites/presentation/views/offers_view.dart';


final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return BlocProvider(
          create: (_) => AuthCubit(),
          child: const LoginView(),
        );
      },
    ),

    ShellRoute(
      builder: (context, state, child) {
        return MainNavigationView(
          location: state.uri.path,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const ProductsView(),
        ),
        GoRoute(
          path: '/explore',
          builder: (context, state) => const _PlaceholderView(title: 'Explore'),
        ),
        GoRoute(
          path: '/cart',
          builder: (context, state) => const _PlaceholderView(title: 'Cart'),
        ),
        GoRoute(
          path: '/offer',
          builder: (context, state) => const OffersView(),
        ),
        GoRoute(
          path: '/account',
          builder: (context, state) => const _PlaceholderView(title: 'Account'),
        ),
      ],
    ),

    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesView(),
    ),

    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        return ProductDetailsView(
          productId: state.pathParameters['id']!,
        );
      },
    ),
  ],
);

class _PlaceholderView extends StatelessWidget {
  final String title;

  const _PlaceholderView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('$title - Coming Soon'),
      ),
    );
  }
}
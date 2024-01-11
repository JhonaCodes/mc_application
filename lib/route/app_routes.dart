import 'dart:developer';

import 'package:deepstatemanagment/ui/layout/home_layout.dart';
import 'package:deepstatemanagment/ui/screen/product_screen.dart';
import 'package:deepstatemanagment/ui/screen/trade_screen.dart';
import 'package:deepstatemanagment/ui/view/product_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Simple [GoRouter] implementation.
///
/// [GoRouter] is a simple router that allows you to create nested routes.
/// But we are using a nesting of routes with [ShellRouter] to maintain the nesting of the routes-
/// this is especially useful for when we are using the [Web] application because we can use direct links -
/// to access a specific part of the application, such as Views or Screens with a form preloaded etc.
///
///
/// Path to access the View of this product http://localhost:8080/#/product/2ed9a3fa-fd96-4118-b291-a9705e70cc44
final GoRouter router = GoRouter(

  initialLocation: '/',
  routes: <RouteBase>[

    ShellRoute(
      routes: [

        GoRoute(
          path: '/',
          name: 'product',
          builder: (BuildContext context, GoRouterState state) => const ProductScreen(),
          routes: [

            GoRoute(
              path: 'product/:id',
              name: ':id',
              builder: (BuildContext context, GoRouterState state) {
                /// Take id of product from path.
                log('${state.pathParameters}');
                log("${state.pathParameters['id']}");

                /// This is a simple way to get the id of the product from the path.
                ///
                /// Current path:
                /// {
                ///   id: 2ed9a3fa-fd96-4118-b291-a9705e70cc44
                /// }
                ///
                final product = state.pathParameters['id'];

                /// Current id of [product]
                ///
                /// 2ed9a3fa-fd96-4118-b291-a9705e70cc44
                return ProductView(productId: product.toString());
              },
            ),

          ],

        ),

        GoRoute(
          path: '/trades',
          name: 'trades',
          builder: (BuildContext context, GoRouterState state) => const TradeScreen(),
        ),

      ],

      builder: (context, state, child) => HomeLayout(child: child,),

    ),

  ],

);

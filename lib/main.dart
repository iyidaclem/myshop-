import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import '../providers/auth.dart';
import '../screens/auth_screen.dart';
import '../screens/edit_product_screen.dart';
import '../screens/cart_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import '../providers/orders.dart';
import '../providers/cart.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth,Products>( 
          update: (ctx, auth,previousProducts) => 
          Products(previousProducts==null?[]:previousProducts.items,auth.token),
          create: (ctx) => Products([]),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth,Orders>(
          update: (ctx,auth,previousOrders)=>
          Orders(previousOrders==null?[]:previousOrders.orders,auth.token),
          create: (ctx) => Orders([]),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MyShop',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
            ),
            home:auth.isAuth ?ProductsOverviewScreen() : AuthScreen(),
            routes: {
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            }),
      ),
    );
  }
}

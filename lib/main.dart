import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_bloc_test/cart/bloc/cart_bloc.dart';
import 'package:shop_bloc_test/cart/bloc/cart_event.dart';
import 'package:shop_bloc_test/catalog/bloc/catalog_bloc.dart';
import 'package:shop_bloc_test/catalog/bloc/catalog_event.dart';
import 'package:shop_bloc_test/my_cart.dart';
import 'package:shop_bloc_test/my_catalog.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CatalogBloc>(
          create: (context) => CatalogBloc()..add(GetCatalog()),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc()..add(LoadCart()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Bloc Shopping Cart',
        initialRoute: '/',
        routes: {
          '/': (context) => MyCatalog(),
          '/cart': (context) => MyCart(),
        },
      ),
    );
  }
}

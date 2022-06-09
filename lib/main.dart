import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_api_project/controller/catagory_controller.dart';
import 'package:second_api_project/controller/order_controller.dart';
import 'package:second_api_project/controller/product_controller.dart';
import 'package:second_api_project/screen/login_page.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<OrderController>(create: (_) => OrderController()),
        ChangeNotifierProvider<CatagoryController>(create: (_) => CatagoryController()),
        ChangeNotifierProvider<ProductController>(create: (_) => ProductController())
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage());
  }
}
